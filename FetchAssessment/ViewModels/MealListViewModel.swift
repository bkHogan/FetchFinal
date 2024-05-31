//
//  MealListViewModel.swift
//  FetchAssessment
//
//  Created by Mac on 5/29/24.
//

import Foundation

class MealListViewModel: ObservableObject {
    
    // List of meals to be displayed
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var searchQuery = "" // Search query

    private let service = MealService()
    
    // Fetch the list of meals
    func fetchMeals() {
        isLoading = true
        service.fetchMeals { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let meals):
                    // Sort meals alphabetically
                    self?.meals = meals.sorted { $0.strMeal < $1.strMeal }
                case .failure(let error):
                    print("Error fetching meals: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Filter the meals based on the search query
        var filteredMeals: [Meal] {
            if searchQuery.isEmpty {
                return meals
            } else {
                return meals.filter { $0.strMeal.lowercased().contains(searchQuery.lowercased()) }
            }
        }
}
