//
//  CustomTable.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 15.08.2023.
//

import SwiftUI

struct CustomTable: View {
    let articles: [Article]
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
            //                        .ignoresSafeArea(.all, edges: .bottom)
            //                        .frame(maxHeight: .infinity)
                .foregroundColor(Color("CustomListColor"))
                .padding(.horizontal)
                .transaction { $0.animation = .default.speed(1.4) }
            ScrollView {
                ForEach(articles, id: \.self) { article in
                    NavigationLink {
                        DetailView(article: article)
                    } label: {
                        if let title = article.title,
                           let description = article.description {
                            CustomCell(title: title, description: description)
                        }
                    }
                }
            }
            .transaction { $0.animation = .default.speed(1.4) }
            .padding(.vertical)
        }
    }
}

struct CustomTable_Previews: PreviewProvider {
    static var previews: some View {
        CustomTable(articles: Article.sampleArticles)
    }
}
