//
//  MainViewVM2.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 14.08.2023.
//

import Foundation

extension MainView {
    @MainActor class MainViewVM: ObservableObject {
        @Published var didSearch: Bool = false
        @Published var searchText = ""
        @Published var articles: [Article] = []
        
        let networkService = NetworkService()
        var filter = Filters.publishedAt
        var savedSearchQuery = ""
        var fromDate: Date?
        var toDate: Date?
        
        private var sortQuery: String {
            switch self.filter {
            case .popularity :
                return "popularity"
            case .publishedAt :
                return "publishedAt"
            case .relevancy :
                return "relevancy"
            }
        }
        
        func loadArticles() {
            guard !savedSearchQuery.isEmpty else { return }
            Task {
                let news = try? await networkService.fetchData(article: savedSearchQuery, sortBy: sortQuery, fromDate: fromDate, toDate: toDate)
                self.articles = news?.articles ?? []
                self.didSearch = true
            }
        }
        
        func clearResults() {
            didSearch = false
            articles = []
        }
        
        func saveSearchQuery() {
            savedSearchQuery = searchText
        }
    }
}
