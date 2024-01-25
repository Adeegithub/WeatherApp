//
//  CityView.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import SwiftUI

struct CityView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @State var location: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                
                RadialGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), center: .center, startRadius: 0, endRadius: 1000).ignoresSafeArea()
                
                let currentTime = Date(timeIntervalSince1970: TimeInterval(weatherViewModel.weatherInfo?.current.dt ?? 0))
                
                let timeOfDay = currentTime.getTimeOfDay(currentTime: weatherViewModel.weatherInfo?.timezone ?? "UTC")
                
                let backgroundImage = bgImage(timeOfDay: timeOfDay)
                
                
                if let currentWeatherInfo = weatherViewModel.weatherInfo {
                    VStack{
                        HStack{
                            TextField("Enter a city",text: $location)
                                .textFieldStyle(.roundedBorder)
                            Button(action: {
                                weatherViewModel.currentCity = location.capitalized
                                Task {
                                    await weatherViewModel.fetchSearchWeatherData()
                                }
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .tint(.purple)
                            })
                            .background(.purple)
                            .foregroundColor(.white)
                            .buttonStyle(.bordered)
                            .cornerRadius(5)
                            
                            Spacer()
                        }
                        
                        .padding(.top,-40)
                        HStack{
                            Image(systemName: "location.fill")
                                .foregroundColor(.black)
                            Text("\(weatherViewModel.CitySearch)")
                                .font(.system(size: 18))
                                .bold()
                        }
                        .frame(width: 190,height: 30)
                        .background(.clear)
                        .cornerRadius(20)
                        .padding(.bottom,-60)
                        
                        //Current Weather Image Section
                        VStack{
                            HStack{
                                Image(imageFilter(image: currentWeatherInfo.current.weather[0]))
                                    .resizable()
                                    .frame(width: 200,height: 200)
                                    .padding(.bottom,-50)
                            }
                            HStack{
                                //Current Temperature
                                Text("\(currentWeatherInfo.current.temp, specifier: "%.0f")°C")
                                    .font(.system(size: 70))
                                    .bold()
                            }
                            
                            HStack{
                                //Current Situation -> Clear Sky, Overcast Clouds
                                Text("\(currentWeatherInfo.current.weather[0].description)".capitalized)
                                    .font(.system(size: 18))
                                    .bold()
                            }
                            
                            
                            let sunsetTime = TimeInterval(currentWeatherInfo.current.sunset ?? 0)
                            let formattedSunsetTime = timeFormat(ts: sunsetTime)
                            
                            let sunriseTime = TimeInterval(currentWeatherInfo.current.sunrise ?? 0)
                            let formattedSunriseTime = timeFormat(ts: sunriseTime)
                            
                            
                            //Sunrise and Sunset Section
                            HStack{
                                Image(systemName: "sunrise.fill")
                                Text(formattedSunriseTime)
                                
                                Image(systemName: "sunset.fill")
                                Text(formattedSunsetTime)
                            }
                            .padding(.all,0.5)
                            .bold()
                            .font(.system(size: 18))
                            
                            
                            HStack{
                                //Date and Time of the City
                                Text("\(weatherViewModel.formattedDate) | \(weatherViewModel.formattedTime)")
                                    .bold()
                                    .font(.system(size: 20))
                            }
                        }
                        
                        Divider()
                            .background(Color.black)
                        
                        //3 Main Weather Conditions
                        HStack{
                            //CurrentWeather Custom Component
                            CurrentWeather(title: "Humidity", currentWeather: currentWeatherInfo.current)
                            CurrentWeather(title: "Pressure", currentWeather: currentWeatherInfo.current)
                            CurrentWeather(title: "WindSpeed", currentWeather: currentWeatherInfo.current)
                            
                        }
                        .padding(.top,-30)
                        
                        VStack{
                            HStack{
                                Text("TODAY")
                                    .font(.title2)
                                    .bold()
                            }
                        }
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(currentWeatherInfo.hourly) { hour in
                                    CurrentWeatherCard(hourlyData: hour, timezone: currentWeatherInfo.timezone) 
                                    //CurrentWeatherCard Component
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        backgroundImage
                            .aspectRatio(contentMode: .fill)
                            .opacity(0.4)
                    )
                } else {
                    ProgressView(){
                        Text("Loading Weather Data")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .progressViewStyle(.circular)
                    .tint(.white)
                }
            }
            .ignoresSafeArea()
            .alert(isPresented: $weatherViewModel.apiError) {
                Alert(title: Text("Something went Wrong!"), message: Text("Error with the API call"), dismissButton: .default(Text("OK"), action: {
                    Task{
                        weatherViewModel.fetchWeatherInfo
                    }
                }))
            }
            .alert(isPresented: $weatherViewModel.locationNotFound) {
                Alert(title: Text("Unable to fetch the location!"), message: Text("Please try again"),  dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

//Background Image Selection Function
private func bgImage(timeOfDay: DaySegment) -> Image {
    switch timeOfDay {
    case .morning:
        return Image("morning")
    case .day:
        return Image("day")
    case .evening:
        return Image("sunset")
    case .night:
        return Image("night") 
    }
}


//Extension for selecting the day phase
extension Date {
    func getTimeOfDay(currentTime: String) -> DaySegment {
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: currentTime) {
            calendar.timeZone = timeZone
        }
        
        let hour = calendar.component(.hour, from: self)

        switch hour {
        case 6..<12:
            return .morning
        case 12..<18:
            return .day
        case 18..<21:
            return .evening
        default:
            return .night
        }
    }
}

enum DaySegment {
    case morning, day, evening, night
}

#Preview {
    CityView().environmentObject(WeatherViewModel())
        .environmentObject(InternetStatusListener())
}
