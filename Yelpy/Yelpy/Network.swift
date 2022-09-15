//
//  Network.swift
//  Yelpy
//
//  Created by Angel Zambrano on 9/13/22.
//

import Foundation
import UIKit



struct API {
    
    /// dowloads image given a url
   static func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
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
    
    
   static func search(str: String,completion: @escaping (Swift.Result<[Business], Error>) -> Void) {
        // ––––– TODO: Add your own API key!
        let apikey = "CPQxOZEqj6LG71HZ_kHdUGIi8XzOd4h4elti8P5fp677vsUqbulXAqZor_w44CdnsLR4cZ_9XM3QVSZThDb8aEAYPGS9EQji6XFak8Jc3hO8E_JRMyKy_N9AETwhY3Yx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)&term=\(str)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
   
        URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                print("error: ", err!)
                return
            }
            
        
            
            guard  let response = response as? HTTPURLResponse else {
                    print("no response")
                return
            }
          
            
            guard response.statusCode == 200 else {
                print("BAD RESPONSE: ", response.statusCode)
                return
            }
            
            guard let data = data else {
                print("no data ")
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
             
                let response = try decoder.decode(Response.self, from: data)
                

                completion(.success(response.businesses))
                
            }
            catch {
                completion(.failure(error))
            }
          
        }.resume()
        
       
    }
    
    
   
    
    /// Gets the movies from the url
     static func fetchBusinesses(completion: @escaping (Swift.Result<[Business], Error>) -> Void)
      {
          
          
          let apikey = "CPQxOZEqj6LG71HZ_kHdUGIi8XzOd4h4elti8P5fp677vsUqbulXAqZor_w44CdnsLR4cZ_9XM3QVSZThDb8aEAYPGS9EQji6XFak8Jc3hO8E_JRMyKy_N9AETwhY3Yx"

          let lat = 37.773972
          let long = -122.431297

          let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
          
          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.addValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
          
          
          URLSession.shared.dataTask(with: request) { data, response, err in
              
              guard err == nil else {
                  print("error: ", err!)
                  return
              }
              
          
              
              guard  let response = response as? HTTPURLResponse else {
                      print("no response")
                  return
              }
            
              
              guard response.statusCode == 200 else {
                  print("BAD RESPONSE: ", response.statusCode)
                  return
              }
              
              guard let data = data else {
                  print("no data ")
                  return
              }
              
              
              do {
                  let decoder = JSONDecoder()
               
                  let response = try decoder.decode(Response.self, from: data)
                  

                  completion(.success(response.businesses))
                  
              }
              catch {
                  completion(.failure(error))
              }
            
          }.resume()


      }
    
    
    }



    
