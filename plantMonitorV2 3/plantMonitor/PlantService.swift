//
//  PlantService.swift
//  plantMonitor
//
//  Created by Yeabsera Damte on 11/22/24.
//

import Foundation
import UIKit
/*
class PlantService {
    let baseURL = "https://openfarm.cc/api/v1/crops"

    // Fetch plant information by name
    func fetchPlantInfo(for plantName: String, completion: @escaping (Result<String, Error>) -> Void) {
        let query = plantName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "\(baseURL)?filter=\(query)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        // Make the API request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("[DEBUG] Network error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("[DEBUG] No HTTP response received")
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            print("[DEBUG] HTTP Status Code: \(httpResponse.statusCode)")

            guard httpResponse.statusCode == 200 else {
                print("[DEBUG] HTTP Error: Status Code \(httpResponse.statusCode)")
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            guard let data = data else {
                print("[DEBUG] No data received")
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            print("[DEBUG] Raw response data: \(String(data: data, encoding: .utf8) ?? "No response body")")

            // Decode the response
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(OpenFarmResponse.self, from: data)
                if let description = response.data.first?.attributes.description {
                    completion(.success(description))
                } else {
                    print("[DEBUG] No description found in response")
                    completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                }
            } catch {
                print("[DEBUG] Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}

// Models for decoding API response
struct OpenFarmResponse: Codable {
    let data: [PlantData]
}

struct PlantData: Codable {
    let attributes: PlantAttributes
}

struct PlantAttributes: Codable {
    let name: String
    let description: String?
    // Add other properties as needed
}
*/






class PlantService {
    let baseURL = "https://openfarm.cc/api/v1/crops"

    // Fetch plant information by name
    func fetchPlantInfo(for plantName: String, completion: @escaping (Result<String, Error>) -> Void) {
        let query = plantName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "\(baseURL)?filter=\(query)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        // Make the API request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("[DEBUG] Network error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("[DEBUG] No HTTP response received")
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            print("[DEBUG] HTTP Status Code: \(httpResponse.statusCode)")

            guard httpResponse.statusCode == 200 else {
                print("[DEBUG] HTTP Error: Status Code \(httpResponse.statusCode)")
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            guard let data = data else {
                print("[DEBUG] No data received")
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            print("[DEBUG] Raw response data: \(String(data: data, encoding: .utf8) ?? "No response body")")

            // Decode the response
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(OpenFarmResponse.self, from: data)
                if let firstData = response.data.first {
                    if let description = firstData.attributes.description {
                        completion(.success(description))
                    } else {
                        print("[DEBUG] No description found in response")
                        // Return an error with custom message
                        let error = NSError(domain: "No data", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not in database (try other; Ex. Tomato, Strawberry, etc.)"])
                        completion(.failure(error))
                    }
                } else {
                    // No data in response
                    print("[DEBUG] No data found in response")
                    // Return an error with custom message
                    let error = NSError(domain: "No data", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not in database (try other; Ex. Tomato, Strawberry, etc.)"])
                    completion(.failure(error))
                }
            } catch {
                print("[DEBUG] Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}

// Models for decoding API response
struct OpenFarmResponse: Codable {
    let data: [PlantData]
}

struct PlantData: Codable {
    let attributes: PlantAttributes
}

struct PlantAttributes: Codable {
    let name: String
    let description: String?
    // Add other properties as needed
}
