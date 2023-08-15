//
//  FilterModalView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct FilterView: View {
    @StateObject var viewModel = FilterViewVM()
    @Environment(\.dismiss) var dismiss
    @Binding var filterType: Filters
    @Binding var fromDate: Date?
    @Binding var toDate: Date?
    @Binding var performSearch: Bool
    let canPerformSearch: Bool
    @State var applyDate = false
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                Button("Apply") {
                    save()
                    dismiss()
                    performSearch.toggle()
                }
            }
            .padding(.horizontal)
            .padding(.top)
            List {
                Picker("Sort By", selection: $viewModel.filter.animation()) {
                    ForEach(Filters.allCases, id: \.self) {
                        filter in Text(filter.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                HStack {
                    Toggle(isOn: $applyDate) {
                        Text("Search for specific dates")
                    }
                }
                if applyDate {
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
                    .disabled(!applyDate)
                    .foregroundColor(applyDate ? Color.primary : Color.gray)
                }
                
                HStack {
                    Button {
                        viewModel.resetToDefault()
                        applyDate = false
                    } label: {
                        Text("Reset")
                    }
                    .buttonStyle(.borderless)
                }
                .frame(maxWidth: .infinity)
            }
            .listStyle(.insetGrouped)
        }
        .onAppear {
            load()
        }
    }
    func save() {
        filterType = viewModel.filter
        fromDate = applyDate ? viewModel.fromDate : nil
        toDate = applyDate ? viewModel.toDate : nil
    }
    func load() {
        viewModel.filter = filterType
        viewModel.fromDate = fromDate ?? viewModel.fromDate
        viewModel.toDate = toDate ?? viewModel.toDate
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filterType: .constant(.publishedAt), fromDate: .constant(Date()), toDate: .constant(Date()), performSearch: .constant(false), canPerformSearch: true, applyDate: false)
    }
}

