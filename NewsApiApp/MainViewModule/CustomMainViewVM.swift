//
//  CustomMainViewVM.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 15.08.2023.
//

import Foundation

extension CustomMainView {
    @MainActor class CustomMainViewVM: ObservableObject {
        @Published var searchText = ""
        @Published var articles: [Article] = []
        var didSearch: Bool = false
        var didFinishLoading = false
        let networkService = NetworkService()
        var filter = Filters.publishedAt
        var fromDate: Date?
        var toDate: Date?
        var applyDate = false
        
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
            guard !searchText.isEmpty else { return }
            self.didFinishLoading = false
            self.didSearch = true
            Task {
                let news = try? await networkService.fetchData(article: searchText, sortBy: sortQuery, fromDate: fromDate, toDate: toDate)
                self.articles = news?.articles ?? []
                self.didFinishLoading = true
            }
        }
        
        func clearResults() {
            didSearch = false
            articles = []
        }
    }
}
