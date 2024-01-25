//
//  DateTimeFormat.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import Foundation

func dateTimeFormat(ts: TimeInterval) -> String { //TimeStamp
    let formattedDate = DateFormatter()
    formattedDate.dateFormat = "d MMM 'at' hh:mm a"
    return formattedDate.string(from: Date(timeIntervalSince1970: ts))
}

func timeFormat(ts: TimeInterval) -> String {
    let formattedTime = DateFormatter()
    formattedTime.dateFormat = "h a"
    return formattedTime.string(from: Date(timeIntervalSince1970: ts))
}

func formatTimeAndDate(ts:TimeInterval)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh a E" //ex -> 4 am Tue
    return dateFormatter.string(from: Date(timeIntervalSince1970: ts))
}

func dateFormat(ts:TimeInterval)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d EEEE" //10 Thursday
    return dateFormatter.string(from: Date(timeIntervalSince1970: ts))
}
