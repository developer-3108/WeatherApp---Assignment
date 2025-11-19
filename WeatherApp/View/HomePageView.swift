//
//  HomePageView.swift
//  WeatherApp
//
//  Created by Akshat Srivastava on 18/11/25.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    @State private var searchQuery: String = ""
    @State private var showSearchBar: Bool = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            // MARK: - SEARCH BAR
            HStack {
                if !showSearchBar {
                    VStack(alignment: .leading) {
                        Text(weatherViewModel.weather?.location.name ?? "")
                            .font(.custom("Montserrat-Light", size: 20))
                            .foregroundStyle(Color.gray)
                        
                        Text(greetingBasedOnTime())
                            .font(.custom("Montserrat-SemiBold", size: 30))
                            .foregroundStyle(Color.white)
                    }
                    
                    Spacer()
                }
                
                if showSearchBar {
                    // MARK: - SEARCH BAR
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.title3)
                                .foregroundStyle(Color.gray)
                            
                            TextField("", text: $searchQuery, prompt: Text("Search").foregroundStyle(Color.gray).font(.title3))
                                .font(.title3)
                                .foregroundStyle(Color.white)
                                .keyboardType(.webSearch)
                                .onSubmit {
                                    let trimmed = searchQuery.trimmingCharacters(in: .whitespaces)

                                    if !trimmed.isEmpty {
                                        weatherViewModel.cityName = trimmed
                                        Task {
                                            await weatherViewModel.fetchWeather()
                                        }
                                        withAnimation(.bouncy) {
                                            showSearchBar = false
                                        }
                                    } else {
                                        weatherViewModel.errorAlertMessage = "Please enter a valid city name."
                                        weatherViewModel.showErrorAlert = true
                                    }
                                }
                        }.padding(10)
                            .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .fill(Color.clear)
                            .glassEffect())
                        .animation(.bouncy, value: showSearchBar)
                        .transition(.blurReplace)
                        
                        Button {
                            withAnimation(.bouncy) {
                                showSearchBar = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                                .padding(10)
                                .background(Circle()
                                    .fill(Color.clear)
                                    .glassEffect())
                        }
                    }
                    
                    
                } else {
                    
                    // MARK: - SEARCH BAR BUTTON
                    Button {
                        withAnimation(.bouncy) {
                            showSearchBar = true
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.white)
                            .font(.title2)
                            .padding(10)
                            .background(Circle().stroke(Color.white, lineWidth: 1))
                    }
                    
                    // MARK: - REFRESH BUTTON
                    Button {
                        Task {
                            await weatherViewModel.fetchWeather()
                        }
                    } label: {
                        Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
                            .foregroundStyle(Color.white)
                            .font(.title2)
                            .padding(10)
                            .background(Circle().stroke(Color.white, lineWidth: 1))
                    }
                }
                
            }.padding(.horizontal)
            
            // MARK: - WEATHER ANIMATION
            WeatherAnimation(weatherName: animationFor(code: weatherViewModel.weather?.current.condition.code ?? 0))
            
            // MARK: - WEATHER DETAILS
            VStack(spacing: 0) {
                Text("\(String(format: "%.1f", weatherViewModel.weather?.current.temp_c ?? 0))°C")
                    .font(.custom("Montserrat-Bold", size: 85))
                Text(weatherViewModel.weather?.current.condition.text ?? "")
                    .textCase(.uppercase)
                    .font(.custom("Montserrat-Medium", size: 35))
                Text("\(weatherViewModel.weather?.location.localtime ?? "")")
                    .font(.custom("Montserrat-Medium", size: 15))
            }.foregroundStyle(Color.white)
                .padding(.bottom)
            
            WeatherDetails(metricA: "Air Quality (PM 2.5)", metricAUnit: "\(weatherViewModel.weather?.current.air_quality.pm2_5 ?? 0)", metricB: "Humidity", metricBUnit: "\(weatherViewModel.weather?.current.humidity ?? 0) %")
            
            Divider()
                .frame(height: 1)
                .overlay {
                    Color.init(.systemGray2)
                }
                .padding(.horizontal)
            
            WeatherDetails(metricA: "Wind Speed", metricAUnit: "\(weatherViewModel.weather?.current.wind_kph ?? 0) kph", metricB: "Wind Direction", metricBUnit: "\(weatherViewModel.weather?.current.wind_dir ?? "")")
            
            Divider()
                .frame(height: 1)
                .overlay {
                    Color.init(.systemGray2)
                }
                .padding(.horizontal)
            
            WeatherDetails(metricA: "Visibility", metricAUnit: "\(weatherViewModel.weather?.current.vis_km ?? 0) km", metricB: "UV", metricBUnit: "\(weatherViewModel.weather?.current.uv ?? 0)")
            
            
        }.backgroundColor()
        .showLoadingAnimation(weatherViewModel.isLoading)
        .refreshable {
            Task {
                await weatherViewModel.fetchWeather()
            }
        }
        .alert(weatherViewModel.errorAlertMessage, isPresented: $weatherViewModel.showErrorAlert) {
            
        }
    }
    
    // MARK: - WEATHER ANIMATION CODE
    func animationFor(code: Int) -> String {
        switch code {
        case 1000:
            return "Sunny"
            
        case 1003, 1006, 1009:
            return "PartlyCloudy"
            
        case 1063, 1150, 1153, 1168, 1171,
             1180, 1183, 1186, 1189,
             1192, 1195, 1240, 1243, 1246,
             1273, 1276:
            return "Rain"
            
        case 1066, 1069, 1114, 1117,
             1210, 1213, 1216, 1219,
             1222, 1225, 1255, 1258,
             1279, 1282:
            return "Snow"
            
        default:
            return "Sunny"
        }
    }
    
    // MARK: - GREETING MESSAGE
    func greetingBasedOnTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<20:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }
}

struct WeatherDetails: View {
    let metricA: String
    let metricAUnit: String
    let metricB: String
    let metricBUnit: String
    
    var body: some View {
        HStack(spacing: 0) {
            
            VStack(alignment: .leading) {
                Text(metricA)
                    .font(.custom("Montserrat-Light", size: 15))
                    .foregroundStyle(Color.gray)
                Text(metricAUnit)
                    .font(.custom("Montserrat-SemiBold", size: 20))
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            VStack(alignment: .leading) {
                Text(metricB)
                    .font(.custom("Montserrat-Light", size: 15))
                    .foregroundStyle(Color.gray)
                Text(metricBUnit)
                    .font(.custom("Montserrat-SemiBold", size: 20))
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.horizontal)
    }
}
//
//#Preview {
//    HomePageView()
//}
