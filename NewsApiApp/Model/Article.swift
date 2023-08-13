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
    
    static let sampleArticle = Article(source: Source(id: nil, name: "SourceName"), author: "Author", title: "Title", description: "Description", url: "some url", urlToImage: "https://s.yimg.com/uu/api/res/1.2/ZoyQPcuhFHhneRSlejgITA--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-08/a067ce70-3854-11ee-afae-e25af94d540d.cf.jpg", publishedAt: "2023-07-11T15:30:00Z", content: "Content")
    
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    var imageUrl: URL? {
        guard let urlString = urlToImage else { return nil }
        return URL(string: urlString)
    }
    var publishingDate: Date? {
        convertStringToDate(date: publishedAt)
    }
    
    private func convertStringToDate(date: String?) -> Date? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: date) {
            return date
        }
        return nil
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
