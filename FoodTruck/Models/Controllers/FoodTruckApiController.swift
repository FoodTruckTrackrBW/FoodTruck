//
//  FoodTruckAPIController.swift
//  FoodTruck
//
//  Created by Stephanie Ballard on 4/27/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

class FoodTruckApiController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case badUrl
        case noAuth
        case badAuth
        case otherError
        case badData
        case noDecode
        case badImage
        case failedFetch
    }
    
//    var truck = [Truck]()
    
    private let baseURL = URL(string: "")!
    private lazy var jsonDecoder = JSONDecoder()
    
    func searchForTruck(searchTerm: String, completion: @escaping (Result<Truck, NetworkError>) () -> Void) {
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print(requestURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to fetch truck data with error \(error)")
                completion(.failure(.failedFetch))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200
                else {
                    print("Fetched truck received bad response")
                    completion(.failure(.failedFetch))
                    return
            }
            
            guard let data = data else {
                return completion(.failure(.badData))
            }
            
            do {
                let truck = try self.jsonDecoder.decode(Truck.self, from data)
                completion(.success(truck))
            } catch {
                print("Error decoding truck names: \(error)")
                completion(.failure(.badData))
            }
        }.resume()
        
        
    }
    
    
}
