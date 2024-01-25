//
//  WeatherForecast.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import SwiftUI

struct WeatherForecast: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @EnvironmentObject var networkMonitor: InternetStatusListener
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), center: .center, startRadius: 0, endRadius: 1000).ignoresSafeArea()
                    VStack{
                        ScrollView(.horizontal){
                            VStack(alignment: .leading){
                                HStack{
                                    //Hourly Card -> Horizontal
                                    ForEach(weatherViewModel.weatherInfo?.hourly ?? []) { hour in
                                        HourlyCard(hour: hour)
                                    }
                                }
                                .padding(.top,-30)
                            }
                        }
                        .padding()
                        VStack {
                            ScrollView(.vertical){
                                VStack{
                                    //Daily Card Component
                                    ForEach(weatherViewModel.weatherInfo?.daily ?? []) { day in
                                        DailyCard(daily: day)
                                    }
                                }
                                .scrollContentBackground(.hidden)
                                .frame(width:geometry.size.width)
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Image(systemName: "sun.min.fill")
                                    .foregroundColor(.black)
                                Text("Weather forcast for \(weatherViewModel.currentCity)")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        }
                        
                    }
                }
            }
        }
    }
}

#Preview {
    WeatherForecast().environmentObject(WeatherViewModel())
        .environmentObject(InternetStatusListener())
}
