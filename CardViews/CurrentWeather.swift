//
//  CurrentWeather.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import SwiftUI

struct CurrentWeather: View {
    var title: String
    var currentWeather: Current
    
    
    var body: some View {
        ZStack{
            VStack{
                Image(selectImage(imageType: title))
                    .resizable()
                    .frame(width: 80,height: 80)
                
                if(title == "Humidity"){
                    Text("\(currentWeather.humidity)%")
                        .font(.system(size: 15))
                        .bold()
                }
                else if(title == "Pressure"){
                    Text("\(currentWeather.pressure)hpa")
                }
                else{
                    Text("\(currentWeather.windSpeed, specifier: "%.0f")mph")
                        .font(.system(size: 15))
                        .bold()
                }
                
                Text(title)
                    .font(.system(size: 13))
                    .bold()
                    .opacity(0.7)
            }
            .padding()
        }
    }
    
    func selectImage(imageType: String) -> String {
        switch imageType{
        case "Humidity":
            return "humidity"
        case "Pressure":
            return "pressure"
        default:
            return "windSpeed"
        }
    }
}
