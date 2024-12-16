//
//  earthquakeData.swift
//  Final project
//
//  Created by yunus on 14.12.2024.
//

import Foundation

struct EarthquakeResponse: Decodable {
    let features: [EarthquakeFeature]
}

struct EarthquakeFeature: Decodable {
    let properties: EarthquakeProperties
    let geometry: Geometry
}

struct EarthquakeProperties: Decodable {
    let mag: Double?
    let place: String
    let time: Double
    let magType: String?
    let title: String?
}

struct Geometry: Decodable {
    let type: String
    let coordinates: [Double]
}

