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
            VStack {
                if !viewModel.didPerformSearch {
                    VStack {
                        ListView(articles: Article.sampleArticles)
                        
                    }
                } else {
                    EmptyView(didSearch: false)
                }
                Spacer()
                Divider()
                Button {
                    viewModel.showFilters = true
                } label: {
                    ApplyButton(text: "Apply Filter")
                }.sheet(isPresented: $viewModel.showFilters) {
                    FilterModalView(filterType: $viewModel.filter, fromDate: $viewModel.fromDate, toDate: $viewModel.toDate)
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




