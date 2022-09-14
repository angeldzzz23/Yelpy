//
//  Network.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/13/22.
//

import Foundation



struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "CPQxOZEqj6LG71HZ_kHdUGIi8XzOd4h4elti8P5fp677vsUqbulXAqZor_w44CdnsLR4cZ_9XM3QVSZThDb8aEAYPGS9EQji6XFak8Jc3hO8E_JRMyKy_N9AETwhY3Yx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
                
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
        
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let restaurants = dataDictionary["businesses"] as! [[String:Any]]
                
                return completion(restaurants)
                  
                }
            }
        
            task.resume()
        
        }
    }

    
