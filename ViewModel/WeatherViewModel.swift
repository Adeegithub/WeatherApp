//
//  WeatherViewModel.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import Foundation
import Observation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var weatherInfo: WeatherModel?
    @Published var currentCityCord: CLLocationCoordinate2D?
    @Published var currentCity: String = "London"
    @Published var CitySearch: String = ""
    @Published var apiError = false
    @Published var locationNotFound = false
    @Published var formattedDate: String = ""
    @Published var formattedTime: String = ""
    @Published var formattedSunrise: String = ""
    @Published var formattedSunset: String = ""
    
    @Published var locations:[Sublocation] = []
    
    
    init(){
        Task {
            await fetchSearchWeatherData()
        }
    }
    
    func fetchWeatherInfo() async throws {
        let url = "https://api.openweathermap.org/data/3.0/onecall?lat=\(String(currentCityCord?.latitude ?? 51.503300))&lon=\(String(currentCityCord?.longitude ?? -0.079400))&units=metric&appid=584a8c5d8dc493376b7f8e63c0edb945"
        
        guard let weatherURL = URL(string: url) else {
            print("Please Check the URL again!")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: weatherURL)
            let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)
            
            DispatchQueue.main.async{
                self.weatherInfo = decodedData
                self.dateTimeUpdate(decodedData.current.dt, sunrise: decodedData.current.sunrise!, sunset: decodedData.current.sunset!)
            }
            print(decodedData)
        }
        catch {
            apiError = true
            print("Something went wrong")
        }
    }
    
    func fetchLocation() async throws {
        let geocoder = CLGeocoder()
        if let cordinates = try? await
            geocoder.geocodeAddressString(currentCity){
            self.CitySearch = cordinates.first?.name ?? ""
            self.currentCityCord = cordinates.first?.location?.coordinate
        }
        else {
            locationNotFound = true
            print("Unable to fetch the location")
        }
    }
    
    func fetchSearchWeatherData() async {
        do {
            try await fetchLocation()
            try await fetchWeatherInfo()
        } catch {
            print("Error Fetching Data")
        }
    }
    
    //Function to Update Date and time corresponding to the region
    private func dateTimeUpdate(_ timestamp: Int, sunrise: Int, sunset: Int) {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let sunrise = Date(timeIntervalSince1970: TimeInterval(sunrise))
        let sunset = Date(timeIntervalSince1970: TimeInterval(sunset))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: weatherInfo?.timezone ?? "UTC")
        dateFormatter.dateFormat = "E dd"
        self.formattedDate = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "hh:mm a"
        self.formattedTime = dateFormatter.string(from: date)
        self.formattedSunrise = dateFormatter.string(from: sunrise)
        self.formattedSunset = dateFormatter.string(from: sunset)
        print("WeatherViewModel - Date and time updated to: \(formattedDate) \(formattedTime)")
    }
}
