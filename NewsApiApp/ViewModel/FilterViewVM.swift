//
//  FilterViewVM.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 14.08.2023.
//

import Foundation

extension FilterModalView {
  @MainActor class FilterViewVM: ObservableObject {
      @Published var fromDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
      @Published var toDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
      @Published var filter = Filters.publishedAt
      
      var dateClosedRange: ClosedRange<Date> {
          let min = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
          let max = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
          return min...max
      }
      
        func resetToDefault() {
            fromDate = Date()
            toDate = Date()
            filter = .publishedAt
        }
    }
}
