//
//  PlacesViewModel.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 6/1/2024.
//

import Foundation

class PlacesViewModel:ObservableObject {
    @Published var locations:[Sublocation] = []
    
    init(){
        loadDataFromBunddle()
    }
    
    
    func loadDataFromBunddle(){
        guard let fileUrl = Bundle.main.url(forResource: "location", withExtension: "json") else{
            print("Could not able to find the file")
            return
        }
        
        do{
            let data = try Data(contentsOf: fileUrl)
            let decodeData = try JSONDecoder().decode(PlaceModel.self, from: data)
            locations = decodeData.locations
        }catch{
            print("There is a error when decoding locations")
        }
        
    }
    
    func filterPlaces(location:String)->[Sublocation]{
        return locations.filter({$0.cityName == location})
    }
}
