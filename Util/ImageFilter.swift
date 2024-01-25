//
//  ImageFilter.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import Foundation

func imageFilter(image:Weather) -> String {
    switch image.main {
    case "Clear" :
        return "clearSky"
    case "Clouds":
        return cloudSelector(cloudImage: image)
    case "Rain":
        return rainTypes(rainImage: image)
    case "Mist" :
        return "mist"
    case "Smoke" :
        return "smoke"
    case "Haze" :
        return "haze"
    case "Fog" :
        return "fog"
    case "Squall" :
        return "squall"
    case "Tornado" :
        return "torando"
    case "Snow" :
        return "snow"
    case "Drizzle" :
        return "lightRain"
    case "Thunderstorm" :
        return "thunder"
    default :
        return "clearSky"
    }
}

func cloudSelector(cloudImage:Weather) -> String {
    switch cloudImage.description {
    case "broken clouds":
        return "brokenClouds"
    case "scattered clouds":
        return "scatteredClouds"
    case "overcast clouds":
        return "overlastClouds"
    default:
        return "clearSky"
    }
}

func rainTypes(rainImage:Weather) -> String {
    switch rainImage.description {
    case "light rain":
        return "lightRain"
    case "moderate rain":
        return "moderateRain"
    case "exteme rain":
        return "heavyRain"
    case "heavy intensity rain":
        return "heavyRain"
    default:
        return "lightRain"
    }
}
