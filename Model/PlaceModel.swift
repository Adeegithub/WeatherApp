//
//  PlaceModel.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import Foundation

struct PlaceModel:Codable {
    let locations: [Sublocation]
}

struct Sublocation: Codable,Identifiable {
    let id = UUID()
    let name:String
    let cityName:String
    let latitude:Double
    let longitude:Double
    let description:String
    var imageNames:[String]
    let link:String
}
