//
//  TouristAttractions.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 6/1/2024.
//

import SwiftUI

struct TouristAttractions: View {
    var locationObject: Sublocation
    
    var body: some View {
        ZStack{
            VStack{
                HStack(spacing: 30){
                    Spacer()
                    VStack{
                        HStack{
                            Text(locationObject.name)
                                .font(.system(size: 15))
                                .bold()
                            Image(systemName: "arrow.right.circle")
                        }
                    }
                }
            }
            .padding()
            
            .frame(width: 350,height: 100)
            .background(RadialGradient(gradient: Gradient(colors: [Color.purple, Color.black]), center: .topTrailing, startRadius: 0, endRadius: 300))
            .foregroundColor(.white)
            .cornerRadius(25)
            
            Image(locationObject.imageNames[0])
                .resizable()
                .frame(width: 140,height: 100)
                .cornerRadius(10)
                .offset(x:-105,y:-1)
                .shadow(color: .black , radius: 2, x: 0, y: 1)
        }
    }
}
