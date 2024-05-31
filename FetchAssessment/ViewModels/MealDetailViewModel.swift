//
//  MealDetailViewModel.swift
//  FetchAssessment
//
//  Created by Mac on 5/29/24.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    
    // Detailed information about a meal
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false

    private let service = MealService()
    
    // Fetch details for a specific meal
    func fetchMealDetail(mealID: String) {
        isLoading = true
        service.fetchMealDetail(mealID: mealID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let mealDetail):
                    self?.mealDetail = mealDetail
                case .failure(let error):
                    print("Error fetching meal detail: \(error.localizedDescription)")
                }
            }
        }
    }
}
