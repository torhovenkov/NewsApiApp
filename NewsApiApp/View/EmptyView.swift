//
//  EmptyView.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 13.08.2023.
//

import SwiftUI

struct EmptyView: View {
    @State var didSearch: Bool
    var body: some View {
        VStack  {
            Group {
                if didSearch{
                    Text("Cannot find results")
                } else {
                    Text("Type for search")
                }
            }
            .font(Font.largeTitle)
            .foregroundColor(Color.gray)
            .padding(.top, 40)
            Spacer()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(didSearch: false)
    }
}
