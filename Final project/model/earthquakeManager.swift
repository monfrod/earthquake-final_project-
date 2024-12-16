//
//  earthquakeManager.swift
//  Final project
//
//  Created by yunus on 14.12.2024.
//
import Foundation
import Alamofire

struct EarthquakeManager {
    
    typealias CompletionHandler = (EarthquakeResponse) -> Void
    let api = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
    
    func fetchEartquake(completion: @escaping CompletionHandler){
        AF.request(api).response { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let decoderData = try decoder.decode(EarthquakeResponse.self, from: data)
                    completion(decoderData)
                }
                catch {
                    print("error")
                }
            }
        }
    }
}

