//
//  NavigationBar.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import SwiftUI

struct NavigationBar: View {
    @StateObject var weatherViewModel: WeatherViewModel = WeatherViewModel()
    @StateObject var placeViewModel: PlacesViewModel = PlacesViewModel()
    
    @StateObject var internetStatusListener: InternetStatusListener = InternetStatusListener()
    @State private var showAlert = false
    
    var body: some View {
        TabView{
            CityView()
                .tabItem {
                    Label("City", systemImage: "magnifyingglass")
                }
                .toolbarBackground(Color.purple.opacity(0.5), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .environmentObject(weatherViewModel)
                .environmentObject(internetStatusListener)
            
            WeatherForecast()
                .tabItem {
                    Label("Forecast", systemImage: "calendar")
                }
                .toolbarBackground(Color.purple.opacity(0.5), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .environmentObject(weatherViewModel)
                .environmentObject(internetStatusListener)
            
            PlaceMap()
                .tabItem {
                    Label("Place Map",systemImage: "map")
                }
                .toolbarBackground(Color.purple.opacity(0.5), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .environmentObject(weatherViewModel)
                .environmentObject(placeViewModel)
                .environmentObject(internetStatusListener)
        }
        .accentColor(.black)
        .tabViewStyle(.automatic)
        
        
        .onAppear {
            if !internetStatusListener.isActive {
                showAlert = true
            }
        }
        
        
        .alert(isPresented: $showAlert) {
            // Show Internet Error
            Alert(
                title: Text("Network Error"),
                message: Text("Make sure you're connected to internet."),
                dismissButton: .default(Text("Retry"), action: {
                    // retry mechanism
                })
            )
        }
        .onChange(of: internetStatusListener.isActive) { newValue in
            // Handling Internet Errors
            showAlert = !newValue // Show the alert when connection is lost
        }
    }
}

#Preview {
    NavigationBar()
}
