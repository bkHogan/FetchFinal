//
//  MealService.swift
//  FetchAssessment
//
//  Created by Mac on 5/29/24.
//

import Foundation

class MealService {
    
    // Fetch the list of dessert meals
    func fetchMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        // The URL for fetching dessert meals
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        // Create a data task to fetch the meals
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                // Decode the JSON data into MealResponse
                let result = try JSONDecoder().decode(MealResponse.self, from: data)
                // Pass the fetched meals to the completion handler
                completion(.success(result.meals))
            } catch {
                completion(.failure(error))
            }
        // Start the data task
        }.resume()
    }

    // Fetch detailed information about a specific meal
    func fetchMealDetail(mealID: String, completion: @escaping (Result<MealDetail, Error>) -> Void) {
        // The URL for fetching meal details by meal ID
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        // Create a data task to fetch the meal details
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                // Decode the JSON data into MealDetailResponse
                let result = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let meal = result.meals.first {
                    // Pass the fetched meal detail to the completion handler
                    completion(.success(meal))
                } else {
                    completion(.failure(NSError(domain: "No meal detail", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        // Start the data task
        }.resume()
    }
}

// Struct to decode the response for the list of meals
struct MealResponse: Decodable {
    let meals: [Meal]
}

// Struct to decode the response for meal details
struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
