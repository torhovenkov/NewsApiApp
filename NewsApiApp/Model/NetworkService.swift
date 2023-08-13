//
//  NetworkService.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import Foundation

struct NetworkService {
    let apiKey = "9776a014ffcf42409f5c22d21af41533"
    
    
    enum FetchingError: Error {
        case cannotDecodeData
        case cannotFetchData
    }

    func fetchData(article: String, sortBy: String) async throws -> News? {
        var urlComponents = URLComponents(string: "https://newsapi.org/v2/everything")!
        urlComponents.queryItems = [
            "q" : article,
            "sortBy" : sortBy,
            "apiKey" : apiKey,
            "pageSize" : "10",
            "page" : "1"
        ].map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw  FetchingError.cannotFetchData }
        let jsonDecoder = JSONDecoder()
        do {
            let news = try jsonDecoder.decode(News.self, from: data)
            return news
        }
        catch {
            print(FetchingError.cannotDecodeData)
        }
        return nil
    }
    
    struct News: Codable {
        let articles: [Article]
    }
    
}
