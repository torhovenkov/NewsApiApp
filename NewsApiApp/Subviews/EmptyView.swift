//
//  EmptyView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct EmptyView: View {
    let text: String
    var body: some View {
        VStack  {
            Text(text)
            .font(Font.largeTitle)
            .foregroundColor(Color.gray)
            .padding(.top, 40)
            Spacer()
        }
        .transaction { $0.animation = .default.speed(1.4) } //Fixes broken animation once tapped on searchbar
    }
}
