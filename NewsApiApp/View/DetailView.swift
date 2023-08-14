//
//  DetailView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI
import SafariServices

struct DetailView: View {
    let article: Article
    var body: some View {
        VStack {
            ScrollView {
                if let date = article.publishingDateFormatted {
                    HStack {
                        Spacer()
                        Text(date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                AsyncImage(url: article.imageUrl) { image in
                    image.resizable().aspectRatio(contentMode: .fit).cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 200)
                .padding()
                if let title = article.title {
                    Text(title)
                        .font(.title2)
                }
                Group {
                    if let description = article.description {
                        Text(description)
                    }
                    if let content = article.content {
                        Text(content)
                    }
                }
                .padding()
                if let author = article.author {
                    HStack {
                        Spacer()
                        Text(author)
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                Spacer()
            }
            .navigationTitle(article.source?.name ?? "Unknown")
            .navigationBarTitleDisplayMode(.inline)
            if let url = article.urlFromString {
                Divider()
                Link(destination: url) {
                    Label("Go to website", systemImage: "link.circle.fill")
                        .font(.system(size: 20))
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(article: Article.sampleArticle)
    }
}
//image, +
//title, +
//description, +
//content, +
//author,
//source, +
//published at, +
//url +

