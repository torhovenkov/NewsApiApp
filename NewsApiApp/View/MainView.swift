//
//  ContentView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewViewModel()
    var body: some View {
        NavigationView {
            SearchableView(viewModel: viewModel)
                .navigationTitle("News")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search news")
                .onSubmit(of: .search) {
                    viewModel.loadArticles()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


struct SearchableView: View {
    @ObservedObject var viewModel: MainViewViewModel
    @Environment(\.dismissSearch) var dismissSearch
    var body: some View {
        VStack {
            if viewModel.didPerformSearch && !viewModel.articles.isEmpty {
                VStack {
                    ListView(articles: viewModel.articles, dismissSearch: dismissSearch)
                }
                .toolbar {
                    Button("Clear") { viewModel.clearResults() }
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
        
    }
}
