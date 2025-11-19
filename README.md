# WeatherApp 🌦️

A modern, efficient iOS application built with **SwiftUI** that provides real-time weather forecasts based on the user's current location or manual city search.

![iOS](https://img.shields.io/badge/iOS-16.0%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.0-orange)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green)

## 📱 App Overview

This application was developed to demonstrate asynchronous data fetching, state management, and modern UI design principles in iOS. It leverages the [WeatherAPI](https://www.weatherapi.com/) to fetch accurate data points including temperature, wind speed, humidity, air quality, and UV index.

### Key Features
* **Automatic Location Detection:** Uses CoreLocation to fetch weather for the user's current coordinates immediately upon launch.
* **Manual City Search:** A robust search interface allows users to look up weather conditions for any city worldwide.
* **Asynchronous Networking:** Smooth data fetching using `async/await` ensures the UI never freezes.
* **Modern UI/UX:**
    * Dynamic gradient backgrounds based on app theme.
    * **Skeleton Loading States:** meaningful placeholders while data is fetching (no "0.0" values).
    * Glassmorphism effects on UI components.
* **Robust Error Handling:** User-friendly alerts for invalid city names or network issues.
* **Pull-to-Refresh:** Native iOS gesture support to update data manually.

---

## 🛠️ Tech Stack

* **Language:** Swift 5
* **UI Framework:** SwiftUI
* **Concurrency:** Swift Concurrency (Async/Await)
* **Location Services:** CoreLocation framework
* **API:** [WeatherAPI.com](https://www.weatherapi.com/)

---

## 🏗️ Architecture

The app follows the **MVVM (Model-View-ViewModel)** architectural pattern to ensure separation of concerns and testability.

1.  **Model:**
    * Defines the data structure (Codable structs) matching the WeatherAPI JSON response.
    * Handles data parsing.
2.  **ViewModel (`WeatherViewModel`):**
    * Acts as the "Brain" of the application.
    * Manages states: `isLoading`, `weatherData`, and `errorMessage`.
    * Handles business logic: Location manager delegates and API networking calls.
3.  **View:**
    * Pure SwiftUI views that observe the ViewModel.
    * Reactive UI that updates automatically based on state changes (e.g., switching from Skeleton view to Real data).

---

## 🚀 Setup & Installation

Follow these steps to run the project locally:

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/yourusername/weather-app-ios.git](https://github.com/yourusername/weather-app-ios.git)
    cd weather-app-ios
    ```

2.  **Open in Xcode**
    * Double-click the `.xcodeproj` file to open the project.

3.  **Configure API Key**
    * This project uses WeatherAPI. You will need a free API key.
    * Sign up at [WeatherAPI.com](https://www.weatherapi.com/).
    * Navigate to `WeatherManager.swift` (or wherever your API call is located).
    * Replace the placeholder string with your key:
        ```swift
        let apiKey = "YOUR_API_KEY_HERE"
        ```

4.  **Build and Run**
    * Select your target simulator (e.g., iPhone 15 Pro) or physical device.
    * Press **Cmd + R** to run.

> **Note:** For the Location feature to work on the Simulator, you must simulate a location via `Features` > `Location` > `Custom Location` (or select a preset) in the Simulator menu.

---

## 📝 Assumptions & Limitations

* **Refresh Functionality:** While the requirements mentioned a refresh "button," this app implements the native **Pull-to-Refresh** gesture. This provides a more standard and fluid iOS user experience while fulfilling the functional requirement of manual updates.
* **Device Support:** The UI is optimized for iPhone Portrait mode. iPad support is enabled but not fully optimized for large-screen layouts.
* **API Limits:** The application uses the Free tier of WeatherAPI. Excessive requests may result in temporary rate limiting.
* **Permissions:** If Location Permission is denied, the app gracefully falls back to a default state where the user must manually search for a city.

---

## 📸 Screenshots

| Loading State (Skeleton) | Data Display | Search & Error Handling |
|:---:|:---:|:---:|
| <img src="path/to/screenshot_loading.png" width="200"> | <img src="path/to/screenshot_data.png" width="200"> | <img src="path/to/screenshot_search.png" width="200"> |

*(Note: Please replace the image paths above with actual screenshots from your recordings).*

---

## 📬 Contact

**Akshat Srivastava**
* [LinkedIn](https://linkedin.com/in/yourprofile)
* [GitHub](https://github.com/yourusername)
