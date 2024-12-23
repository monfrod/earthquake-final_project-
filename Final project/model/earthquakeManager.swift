//
//  earthquakeManager.swift
//  Final project
//
//  Created by yunus on 14.12.2024.
//
import Foundation
import Alamofire

struct AFManager {
    
    typealias CompletionHandlerEarthquake = (EarthquakeResponse) -> Void
    typealias CompletionHandlerNews = (NewsData) -> Void
    let api = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
    let newsApi = "https://newsapi.org/v2/everything?from=2024-12-14&sortBy=publishedAt&apiKey=415b002b2faa49689878e12f5f4c2b01&q=earthquake"
    
    func fetchEartquake(completion: @escaping CompletionHandlerEarthquake){
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
    
    func fetchNews(completion: @escaping CompletionHandlerNews){
        AF.request(newsApi).response { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let decoderData = try decoder.decode(NewsData.self, from: data)
                    completion(decoderData)
                }
                catch {
                    print("error")
                }
            }
        }
    }

}

