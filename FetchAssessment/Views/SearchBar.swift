//
//  SearchBar.swift
//  FetchAssessment
//
//  Created by Mac on 5/30/24.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let processedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            // Remove non-alphabet characters
            let cleanedText = processedText.components(separatedBy: CharacterSet.letters.inverted).joined()
            text = cleanedText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search meals"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
