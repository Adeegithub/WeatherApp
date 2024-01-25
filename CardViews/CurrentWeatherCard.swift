//
//  CurrentWeatherCard.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import SwiftUI

struct CurrentWeatherCard: View {
    
    //Current Weather Card in CityView
    var hourlyData:Hourly
    var timezone: String
    
    var body: some View {
        VStack{
            Text(hourlyData.formattedHour(timezone: timezone))
                .bold()
                .font(.system(size: 12))
            
            Image(imageFilter(image: hourlyData.weather[0]))
                .resizable()
                .frame(width: 50,height: 50)
            
            Text("\(hourlyData.temp, specifier: "%.0f")°C")
                .bold()
                .font(.system(size: 12))
        }
        .frame(width: 73,height: 100)
        .background(RadialGradient(gradient: Gradient(colors: [Color.purple, Color.black]), center: .center, startRadius: 0, endRadius: 70))
        .foregroundColor(.white)
        .cornerRadius(15)
    }
}

extension Hourly{
    func formattedHour(timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self.dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"  // Example format: "4 PM"
        if let tz = TimeZone(identifier: timezone) {
            formatter.timeZone = tz
        }
        return formatter.string(from: date)
    }
}
