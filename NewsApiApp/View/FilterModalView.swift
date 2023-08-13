//
//  FilterModalView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct FilterModalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var filterType: Filters
    @Binding var fromDate: Date
    @Binding var toDate: Date
    let canPerformSearch: Bool
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    Text("resets to default")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Button("Save") {
                        dismiss()
                    }
                    Text("doesn't perform search")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            List {
                Picker("Sort By", selection: $filterType.animation()) {
                    ForEach(Filters.allCases, id: \.self) {
                        filter in Text(filter.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                Group {
                    DatePicker(selection: $fromDate, displayedComponents: .date) {
                        Text("From:")
                    }
                    DatePicker(selection: $toDate, displayedComponents: .date) {
                        Text("To:")
                    }
                }
                .datePickerStyle(.compact)
                
            }
            .listStyle(.inset)
            Spacer()
            Button {
                dismiss()
            } label: {
                ApplyButton(text: "Apply and Search", disabled: !canPerformSearch)
            }
            .disabled(!canPerformSearch)
            

        }
    }
}

struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        FilterModalView(filterType: .constant(.publishedAt), fromDate: .constant(Date()), toDate: .constant(Date()), canPerformSearch: true)
    }
}
