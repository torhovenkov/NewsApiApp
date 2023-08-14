//
//  ApplyButton.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI
/// Appearance for buttons
struct FilterButton: View {
    let text: String
    var disabled: Bool = false
    var body: some View {
        Text(text)
            .frame(width: 250, height: 50)
            .background(disabled ? .gray : .blue )
            .foregroundColor(.white)
            .font(.system(size: 25, weight: .semibold))
            .cornerRadius(10)
            .padding(.bottom, 5)
    }
}
