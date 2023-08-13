//
//  ContentView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            Group {
                if !viewModel.didPerformSearch {
                    VStack {
                        ListView(articles: Article.sampleArticles)
                        Spacer()
                        Divider()
                        Button {
                            //I will show modal
                        } label: {
                            HStack {
                                
                            }
                        }
                        
                    }
                } else {
                    EmptyView(didSearch: false)
                }
            }
            .navigationTitle("News")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Type to search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


