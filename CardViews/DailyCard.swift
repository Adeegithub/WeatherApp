//
//  DailyCard.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 6/1/2024.
//

import SwiftUI

struct DailyCard: View {
    
    var daily: Daily
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("\(daily.temp.day, specifier: "%.0f")°C")
                            .padding(.bottom,12)
                            .font(.system(size: 33))
                            .bold()
                        
                        Text("\(daily.weather[0].description)".capitalized)
                            .font(.system(size: 16))
                            .bold()
                        
                        Text("H: \(String(format:"%.0f",daily.temp.max))°C - L: \(String(format:"%.0f",daily.temp.min))°C")
                            .font(.system(size: 12))
                            .bold()
                        
                        let timestamp = TimeInterval(daily.dt)
                        let formattedDate = dateFormat(ts: timestamp)
                        
                        Text(formattedDate)
                            .font(.system(size: 12))
                            .bold()
                    }
                    Spacer()
                    
                }
                .padding()
                .frame(width: 350,height: 130)
                .background(RadialGradient(gradient: Gradient(colors: [Color.purple, Color.black]), center: .trailing, startRadius: 0, endRadius: 400))
                .foregroundColor(.white)
                .cornerRadius(15)
            }
            Image(imageFilter(image: daily.weather[0]))
                .resizable()
                .frame(width: 95,height: 95)
                .offset(x:135,y:-12)
        }
        
    }
    
}
