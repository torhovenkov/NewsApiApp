//
//  Filters.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

enum Filters: String, CaseIterable {
    /// Default
    case publishedAt = "Newest"
    case relevancy = "Relevant"
    case popularity = "Most popular"
    
}
