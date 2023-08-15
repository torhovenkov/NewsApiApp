//
//  Article.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import Foundation

struct Article: Codable, Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.url == rhs.url && lhs.publishedAt == rhs.publishedAt
    }
    
    static let sampleArticle = Article(source: Source(id: nil, name: "BBC News"), author: "Author", title: "Some very important news", description: "Some very important news are here, click to see more.", url: "https://www.bbc.com/news/av/world-europe-66423973", urlToImage: "https://www.svetandroida.cz/media/2023/08/macbook-air-m2-slevy.jpg", publishedAt: "2023-07-11T15:30:00Z")
    static var sampleArticles: [Article] {
        var articles: [Article] = []
        for num in 0..<10 {
            articles.append(sampleArticle)
            articles[num].url = "Https://\(num).com"
        }
        return articles
    }
    
    let source: Source?
    let author, title, description: String?
    var url: String?
    let urlToImage: String?
    let publishedAt: String?
    
    var imageUrl: URL? {
        guard let urlString = urlToImage else { return nil }
        return URL(string: urlString)
    }
    var publishingDate: Date? {
        guard let date = publishedAt else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: date) {
            return date
        }
        return nil
    }
    
    var publishingDateFormatted: String? {
        guard let date = publishingDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: date)
    }
    
    var urlFromString: URL? {
        guard let urlString = url else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
    
}
struct TestArticle: Hashable {
    //Test data
    let title: String
    let description: String
}

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
