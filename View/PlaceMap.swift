//
//  PlaceMap.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import SwiftUI
import MapKit

struct PlaceMap: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @EnvironmentObject var placeViewModel: PlacesViewModel
    @EnvironmentObject var networkMonitor: InternetStatusListener
    
    @State private var showAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack{
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), center: .center, startRadius: 0, endRadius: 1000).ignoresSafeArea()
                    VStack{
                        VStack{
                            VStack{
                                Map{
                                    //Map Section
                                    ForEach(placeViewModel.filterPlaces(location: weatherViewModel.currentCity)) { location in
                                        Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                                    }
                                }
                                
                            }
                            .frame(height: 300)
                        }
                        VStack{
                            Text("Tourist Attractions in \(weatherViewModel.currentCity)")
                                .bold()
                                .foregroundColor(.white)
                            
                            ScrollView(.vertical){
                                VStack{
                                    ForEach(placeViewModel.filterPlaces(location: weatherViewModel.currentCity)) { object in
                                        NavigationLink(destination: {
                                            //Place Descreption View Model
                                            PlaceDescreption(locationObject: object)
                                        }) {
                                            //Tourist Attractions Card View
                                            TouristAttractions(locationObject: object)
                                        }
                                    }
                                }
                                .scrollContentBackground(.hidden)
                                .frame(width:geometry.size.width)
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("No Tourist Locations Found"), message: Text("There are no tourist locations available."), dismissButton: .default(Text("OK")))
                                }
                                .onAppear {
                                        if placeViewModel.filterPlaces(location: weatherViewModel.currentCity).isEmpty {
                                            showAlert = true
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .accentColor(.white)
        }
    }
}

#Preview {
    PlaceMap()
        .environmentObject(WeatherViewModel())
        .environmentObject(PlacesViewModel())
        .environmentObject(InternetStatusListener())
}
