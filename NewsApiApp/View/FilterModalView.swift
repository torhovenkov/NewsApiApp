//
//  FilterModalView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct FilterModalView: View {
    @StateObject var viewModel = FilterViewVM()
    @Environment(\.dismiss) var dismiss
    @Binding var filterType: Filters
    @Binding var fromDate: Date?
    @Binding var toDate: Date?
    @Binding var performSearch: Bool
    let canPerformSearch: Bool
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    Text("Cancel changes")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                    Text("doesn't perform searching")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            List {
                Picker("Sort By", selection: $viewModel.filter.animation()) {
                    ForEach(Filters.allCases, id: \.self) {
                        filter in Text(filter.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                HStack {
                    Toggle(isOn: $viewModel.applyDate) {
                        Text("Search for specific dates")
                    }
                }
                if viewModel.applyDate {
                    Group {
                        DatePicker(selection: $viewModel.fromDate, in: viewModel.dateClosedRange, displayedComponents: .date) {
                            Label("From:", systemImage: "calendar")
                        }
                        DatePicker(selection: $viewModel.toDate, in: viewModel.dateClosedRange, displayedComponents: .date) {
                            Label("To:", systemImage: "calendar")
                        }
                        }
                    .labelStyle(.titleOnly)
                        .datePickerStyle(.compact)
                        .disabled(!viewModel.applyDate)
                        .foregroundColor(viewModel.applyDate ? Color.primary : Color.gray)
                }
                
                HStack {
                    Button {
                        viewModel.resetToDefault()
                    } label: {
                        Text("Reset")
                    }
                    .buttonStyle(.borderless)
                }
                .frame(maxWidth: .infinity)
            }
            .listStyle(.insetGrouped)
            Button {
                save()
                performSearch = true
                dismiss()
            } label: {
                FilterButton(text: "Apply and Search", disabled: !canPerformSearch)
            }
            .disabled(!canPerformSearch)
            
            
        }
        .onAppear {
            load()
        }
    }
    func save() {
        filterType = viewModel.filter
        fromDate = viewModel.applyDate ? viewModel.fromDate : nil
        toDate = viewModel.applyDate ? viewModel.toDate : nil
    }
    func load() {
        viewModel.filter = filterType
    }
}

struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        FilterModalView(filterType: .constant(.publishedAt), fromDate: .constant(Date()), toDate: .constant(Date()), performSearch: .constant(false), canPerformSearch: true)
    }
}

