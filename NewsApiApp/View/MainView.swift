//
//  MainView2.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 14.08.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewVM()
    var body: some View {
        NavigationView {
            SearchableView(viewModel: viewModel)
                .navigationTitle("News")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search news")
                .onSubmit(of: .search) {
                    viewModel.saveSearchQuery()
                    viewModel.loadArticles()
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
extension MainView {
    struct SearchableView: View {
        @ObservedObject var viewModel: MainViewVM
        @State var showFiltersView: Bool = false
        @State var performSearch: Bool = false
        @State var applyDate: Bool = false
        @Environment(\.dismissSearch) var dismissSearch
        var body: some View {
            VStack{
                if viewModel.didSearch {
                    if viewModel.articles.isEmpty {
                        EmptyView(text: "Cannot Find Results")
                    }
                    else {
                        ListView(articles: viewModel.articles, dismissSearch: dismissSearch)
                    }
                } else {
                    EmptyView(text: "Type to search")
                }
                Spacer()
                Button {
                    showFiltersView = true
                } label: {
                    FilterButton(text: "Filters")
                }
                .sheet(isPresented: $showFiltersView) {
                    FilterModalView(filterType: $viewModel.filter, fromDate: $viewModel.fromDate, toDate: $viewModel.toDate, performSearch: $performSearch, canPerformSearch: viewModel.didSearch || !viewModel.searchText.isEmpty, applyDate: $applyDate)
                }
                .onChange(of: performSearch) { newValue in
                    if !viewModel.didSearch {
                        viewModel.saveSearchQuery()
                    }
                    if newValue {
                        viewModel.loadArticles()
                    }
                    performSearch = false
                }

            }
            .toolbar {
                Button("Clear") { viewModel.clearResults() }
                    .disabled(!viewModel.didSearch)
            }
        }
        
    }
}

