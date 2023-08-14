//
//  MainViewVM.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import Foundation

@MainActor class MainViewViewModel: ObservableObject {
    @Published var filter = Filters.publishedAt
    @Published var articles: [Article] = []
    @Published var didPerformSearch: Bool = false
    @Published var showFilters: Bool = false
    @Published var fromDate: Date = Date()
    @Published var toDate: Date = Date()
    @Published var didApplyDate: Bool = false
    var searchText: String = ""
    let allFilters: [Filters] = Filters.allCases
    let networkService = NetworkService()
    var savedSearchQuery = ""
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
        self.didPerformSearch = !savedSearchQuery.isEmpty
        guard !savedSearchQuery.isEmpty else { return }
        Task {
            let news = try? await networkService.fetchData(article: self.savedSearchQuery, sortBy: sortQuery)
            self.articles = news?.articles ?? []
        }
    }
    
    func clearResults() {
        didPerformSearch = false
        articles = []
    }
}


