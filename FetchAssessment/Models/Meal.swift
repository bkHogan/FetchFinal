//
//  Meal.swift
//  FetchAssessment
//
//  Created by Mac on 5/29/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?

    
    // Use idMeal as the identifier for the Meal
    var id: String { idMeal }
}
