//
//  MealDetailView.swift
//  FetchAssessment
//
//  Created by Mac on 5/29/24.
//

import SwiftUI

// View to display the details of a selected meal
struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading meal details...")
            } else if let meal = viewModel.mealDetail {
                VStack(alignment: .leading, spacing: 16) {
                    Text(meal.strMeal)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let urlString = meal.strMealThumb, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                    }
                    
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(meal.strInstructions)
                        .font(.body)
                    
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(meal.ingredients, id: \.self) { ingredient in
                        // Display each ingredient and measurement
                        Text(ingredient)
                    }
                }
                .padding()
            } else {
                Text("No meal details available.")
            }
        }
        .onAppear {
            // Fetch meal details when the view appears
            viewModel.fetchMealDetail(mealID: mealID)
        }
        .navigationTitle("Meal Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
