//
//  FilterViewVM.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 14.08.2023.
//

import Foundation

extension FilterModalView {
  @MainActor class FilterViewVM: ObservableObject {
        @Published var applyDate: Bool = false
        @Published var fromDate = Date()
        @Published var toDate = Date()
        @Published var filter = Filters.publishedAt
        
        func resetToDefault() {
            applyDate = false
            fromDate = Date()
            toDate = Date()
            filter = .publishedAt
        }
    }
}
