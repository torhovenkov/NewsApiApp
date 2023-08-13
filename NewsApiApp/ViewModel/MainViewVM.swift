//
//  MainViewVM.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import Foundation

extension MainView {
    @MainActor class ViewModel: ObservableObject {
        @Published var filter = Filters.publishedAt
        @Published var articles: [Article] = []
        @Published var didPerformSearch: Bool = false
        var searchText: String = ""
        let allFilters: [Filters] = Filters.allCases
        let networkService = NetworkService()
        var searchQuery = ""
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
            searchQuery = searchText
            self.didPerformSearch = !searchQuery.isEmpty
            guard !searchQuery.isEmpty else { return }
            Task {
                let news = try? await networkService.fetchData(article: self.searchQuery, sortBy: sortQuery)
                self.articles = news?.articles ?? []
            }
        }
        
        
        enum Filters: String, CaseIterable {
            /// Default
            case publishedAt = "Newest"
            case relevancy = "Relevant"
            case popularity = "Most popular"
            
        }
        
    }
    
}
