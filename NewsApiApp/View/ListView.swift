//
//  ListView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct ListView: View {
    let articles: [Article]
    var body: some View {
        List(articles , id: \.self) { article in
            NavigationLink {
                DetailView(article: article)
            } label: {
                VStack(alignment: .leading) {
                    if let title = article.title, let description = article.description {
                        Text(title)
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding(.bottom, 2.0)
                        Text(description)
                    }
                }
                
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(articles: Article.sampleArticles)
    }
}
