//
//  CustomMainView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 15.08.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewVM()
    @State var showFilters = false
    @State var userApplyFilters = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("CustomBackground")
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Group {
                            Text("Sorting by:")
                            Text(viewModel.filter.rawValue)
                        }
                        .foregroundColor(Color.gray)
                        Spacer()
                        Button {
                            showFilters = true
                        } label: {
                            HStack {
                                Text("Filter")
                                Image(systemName: "slider.horizontal.3")
                            }
                        }
                        .buttonStyle(.bordered)
                        .sheet(isPresented: $showFilters) {
                            FilterView(filterType: $viewModel.filter, fromDate: $viewModel.fromDate, toDate: $viewModel.toDate, performSearch: $userApplyFilters, canPerformSearch: !viewModel.searchText.isEmpty)
                        }
                        .onChange(of: userApplyFilters) { _ in
                            viewModel.loadArticles() //value doesn't matter. Once user touches button "apply" it toggles value and triggers searching
                        }
                        
                    }
                    .padding(.horizontal)
                    .transaction { $0.animation = .default.speed(1.4) }
                    CustomListView()
                        .environmentObject(viewModel)
                        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search news")
                        .onSubmit(of: .search, {
                            viewModel.loadArticles()
                        })
                        .onChange(of: viewModel.searchText, perform: { newValue in
                            if newValue.isEmpty {
                                viewModel.clearResults()
                            }
                        })
                        .navigationTitle("News")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            
        }
    }
    
    //MARK: - List view
    
    struct CustomListView: View {
        @EnvironmentObject var viewModel: MainViewVM
        var body: some View {
            if !viewModel.didSearch {
                EmptyView(text: "Type to search")
            } else if viewModel.didSearch && viewModel.articles.isEmpty {
                if viewModel.didFinishLoading {
                    EmptyView(text: "No results")
                    Spacer()
                } else {
                    ProgressView()
                        .padding(.top, 150)
                    Spacer()
                }
            } else {
                CustomTable(articles: viewModel.articles)
            }
        }
    }
    
}

struct CustomMainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




