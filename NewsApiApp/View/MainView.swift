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
                if viewModel.didPerformSearch && !viewModel.articles.isEmpty {
                    VStack {
                        ListView(articles: viewModel.articles)
                        
                    }
                } else {
                    EmptyView(didSearch: viewModel.didPerformSearch)
                }
                Spacer()
                Divider()
                Button {
                    viewModel.showFilters = true
                } label: {
                    ApplyButton(text: "Apply Filter", disabled: false)
                }.sheet(isPresented: $viewModel.showFilters) {
                    FilterModalView(filterType: $viewModel.filter, fromDate: $viewModel.fromDate, toDate: $viewModel.toDate, canPerformSearch: viewModel.didPerformSearch)
                }
            }
            
            .navigationTitle("News")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search news")
            .onSubmit(of: .search) {
                viewModel.loadArticles()
            }
            .toolbar {
                Button("Clear") {
                    viewModel.clearResults()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




