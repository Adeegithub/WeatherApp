//
//  PlaceDescreption.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 6/1/2024.
//

import SwiftUI

struct PlaceDescreption: View {
    var locationObject: Sublocation
    @State var locationImage: String = ""
    
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    RadialGradient(gradient: Gradient(colors: [Color.purple, Color.black]), center: .center, startRadius: 0, endRadius: 1000).ignoresSafeArea()
                    ScrollView(.vertical){
                        VStack{
                            VStack{
                                Image(locationImage)
                                    .resizable()
                                    .frame(width: 370,height: 300)
                                    .cornerRadius(10)
                                    .shadow(color: .black , radius: 5, x: 0, y: 1.5)
                            }
                            VStack{
                                HStack{
                                    Text(locationObject.name)
                                        .font(.system(size: 20))
                                        .foregroundStyle(.white)
                                        .bold()
                                    
                                    Spacer()
                                }
                                .padding()
                                
                                HStack{
                                    Text(locationObject.description)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15))
                                    
                                    Spacer()
                                }
                                .padding()
                            }
                            
                            VStack{
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(locationObject.imageNames,id:\.self) {image in
                                            Button(action: {
                                                locationImage = image
                                            }, label: {
                                                Image(image)
                                                    .resizable()
                                                    .frame(width: 100,height: 100)
                                                    .cornerRadius(15)
                                                    .shadow(color: locationImage == image ? .black : .clear, radius: 5, x: 0, y: 1.5)
                                            })
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                        .navigationTitle(locationObject.cityName)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Text(locationObject.cityName)
                                        .font(.headline)
                                        .bold()
                                }
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            }
                        }
                        .onAppear{
                            locationImage = locationObject.imageNames[0]
                        }
                    }
                }
            }
        }
    }
}
    
