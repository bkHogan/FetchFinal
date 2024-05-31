//
//  MealDetail.swift
//  FetchAssessment
//
//  Created by Mac on 5/29/24.
//

import Foundation

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String?
    
    let ingredients: [String]

    // Custom CodingKeys to map JSON keys to our properties
    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
    }
    
    // Custom initializer to decode JSON and build the ingredients list
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        
        var ingredients = [String]()
        for index in 1...5 {
            // Fetch each ingredient and its corresponding measurement
            if let ingredient = try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strIngredient\(index)")!),
               let measure = try container.decodeIfPresent(String.self, forKey: CodingKeys(rawValue: "strMeasure\(index)")!),
               !ingredient.isEmpty {
                // Append only if the ingredient is not empty
                ingredients.append("\(ingredient) - \(measure)")
            }
        }
        
        // Assign the filtered list to the ingredients property
        self.ingredients = ingredients
    }
}
