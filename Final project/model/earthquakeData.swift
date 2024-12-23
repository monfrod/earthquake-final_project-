//
//  earthquakeData.swift
//  Final project
//
//  Created by yunus on 14.12.2024.
//

import Foundation

//MARK: For Earthquake
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

// MARK: For News
struct NewsData: Decodable {
//    let status: String
//    let totalResults: Int?
    let articles: [Article]
}

struct Article: Decodable {
//    let source: Source
//    let author: String?
    let title: String?
//    let description: String?
    let url: String
    let urlToImage: String?
//    let publishedAt: String
//    let content: String?
}

//struct Source: Decodable {
//    let id: String?
//    let name: String?
//}

