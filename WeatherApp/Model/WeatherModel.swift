//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Akshat Srivastava on 18/11/25.
//

import Foundation

// MARK: - Weather Model
struct WeatherModel: Decodable {
    let location: Location
    let current: Current
}

// MARK: - Location
struct Location: Decodable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}

// MARK: - Current
struct Current: Decodable {
    let last_updated_epoch: Int
    let last_updated: String
    let temp_c: Double
    let temp_f: Double
    let is_day: Int
    let condition: Condition
    
    let wind_mph: Double
    let wind_kph: Double
    let wind_degree: Int
    let wind_dir: String

    let pressure_mb: Double
    let pressure_in: Double
    let precip_mm: Double
    let precip_in: Double

    let humidity: Int
    let cloud: Int
    let feelslike_c: Double
    let feelslike_f: Double
    let windchill_c: Double
    let windchill_f: Double
    let heatindex_c: Double
    let heatindex_f: Double
    let dewpoint_c: Double
    let dewpoint_f: Double

    let vis_km: Double
    let vis_miles: Double
    let uv: Double
    let gust_mph: Double
    let gust_kph: Double

    let air_quality: AirQuality

    let short_rad: Double
    let diff_rad: Double
    let dni: Double
    let gti: Double
}

// MARK: - Condition
struct Condition: Decodable {
    let text: String
    let icon: String
    let code: Int
}

// MARK: - Air Quality
struct AirQuality: Decodable {
    let co: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let us_epa_index: Int
    let gb_defra_index: Int

    enum CodingKeys: String, CodingKey {
        case co, no2, o3, so2, pm2_5, pm10
        case us_epa_index = "us-epa-index"
        case gb_defra_index = "gb-defra-index"
    }
}
