//
//  ApplyButton.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct ApplyButton: View {
    let text: String
    let disabled: Bool
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
