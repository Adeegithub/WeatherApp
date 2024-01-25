//
//  HourlyCard.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 6/1/2024.
//

import SwiftUI

struct HourlyCard: View {
    var hour: Hourly
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Text("\(hour.temp, specifier: "%.0f")°C")
                        .padding(.top,25)
                        .font(.system(size: 20))
                        .bold()
                       // .foregroundColor(.black)
                    
                    Text(hour.weather[0].description.capitalized)
                        .font(.caption)
                        .bold()
                    //.foregroundColor(.black)
                    
                    let timestamp = TimeInterval(hour.dt)
                    let formattedTimeDate = formatTimeAndDate(ts: timestamp)
                    
                    Text(formattedTimeDate)
                        .font(.system(size: 12))
                        .bold()
                       // .foregroundColor(.black)

                }
                .padding()
                .frame(width: 135,height: 115)
                .background(RadialGradient(gradient: Gradient(colors: [Color.purple, Color.black]), center: .center, startRadius: 0, endRadius: 128))
                .foregroundColor(.white)
                .cornerRadius(15)
                .foregroundColor(.black)
            }
            
            Image(imageFilter(image: hour.weather[0]))
                .resizable()
                .frame(width:90,height: 90)
                .offset(y: -60)
        }
        .padding(.top,60)
    }
}

