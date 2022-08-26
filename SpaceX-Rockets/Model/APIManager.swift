//
//  APIManager.swift
//  SpaceX-Rockets
//
//  Created by Pavel on 26.08.22.
//

import Foundation

// get via network Rockets API
struct APIManager {
    private static let urlRocketsEndpoint = "https://api.spacexdata.com/v4/rockets"
    
    public static func GetRocket(completion: @escaping ((Rocket) -> Void))
    {
        let url = URL(string: urlRocketsEndpoint)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print("The response is : ", String(data: data, encoding: .utf8)!)
            
            let decoder = JSONDecoder()
            
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                if rockets.count > 0 {
                    DispatchQueue.main.async {
                        completion(rockets[0])
                    }
                }
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        task.resume()
    }
    
}

