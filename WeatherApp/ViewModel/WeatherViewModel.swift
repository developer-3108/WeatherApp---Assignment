//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Akshat Srivastava on 18/11/25.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var weather: WeatherModel?
    @Published var isLoading: Bool = false
    
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var cityName: String = ""
    
    private var hasFetchedLocation = false
    
    @Published var errorAlertMessage: String = ""
    @Published var showErrorAlert: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // MARK: - LOCATION ACCESS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !hasFetchedLocation else { return }
        
        hasFetchedLocation = true
        manager.stopUpdatingLocation()            
        
        guard let loc = locations.first else { return }
        
        fetchCity(from: loc)
    }
    
    // MARK: - FETCH CITY NAME
    func fetchCity(from location: CLLocation) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let city = placemarks?.first?.locality else { return }

            DispatchQueue.main.async {
                self.cityName = city
                print("City detected:", city)

                Task {
                    await self.fetchWeather()
                }
            }
        }
    }
    
    // MARK: - FETCH WEATHER
    func fetchWeather() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let apiKey = Secrets.apiKey
        
        print("Starting to fetch Weather")
        print(self.cityName)
        do {
            guard let encodedCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(encodedCity)&aqi=yes")
            else {
                print("URL encoding failed")
                return
            }
            print("API: \(url)")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try? JSONDecoder().decode(WeatherModel.self, from: data)
            DispatchQueue.main.async {
                self.weather = response
            }
            await MainActor.run {
                self.weather = response
                print("Weather inside main:", self.weather ?? "nil")
            }
            print("Weather fetched successfully")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        } catch {
            errorAlertMessage = error.localizedDescription
            showErrorAlert = true
            print("Error fetching Weather: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
