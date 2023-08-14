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
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @Binding var applyDate: Bool
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
                Group {
                    DatePicker(selection: $viewModel.fromDate, displayedComponents: .date) {
                        Text("From:")
                    }
                    DatePicker(selection: $viewModel.toDate, displayedComponents: .date) {
                        Text("To:")
                    }
                }
                .datePickerStyle(.compact)
                .disabled(!viewModel.applyDate)
                .foregroundColor(viewModel.applyDate ? Color.primary : Color.gray)
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
                ApplyButton(text: "Apply and Search", disabled: !canPerformSearch)
            }
            .disabled(!canPerformSearch)
            
            
        }
        .onAppear {
            load()
        }
    }
    func save() {
        filterType = viewModel.filter
        fromDate = viewModel.fromDate
        toDate = viewModel.toDate
        applyDate = viewModel.applyDate
    }
    func load() {
        viewModel.filter = filterType
        viewModel.fromDate = fromDate
        viewModel.toDate = toDate
        viewModel.applyDate = applyDate
    }
}

struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        FilterModalView(filterType: .constant(.publishedAt), fromDate: .constant(Date()), toDate: .constant(Date()), applyDate: .constant(false), performSearch: .constant(false), canPerformSearch: true)
    }
}

