//
//  CustomCell.swift
//  NewsApiApp
//
//  Created by Vladyslav Torhovenkov on 15.08.2023.
//

import SwiftUI

struct CustomCell: View {
    let title: String
    let description: String
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text(title)
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.bottom)
                    Text(description)
                }
                .multilineTextAlignment(.leading)
                Spacer()
                Label("Open Article", systemImage: "chevron.forward")
                    .labelStyle(.iconOnly)
                    .foregroundColor(Color.blue)
                    .padding(.leading)
                
            }
            .foregroundColor(Color(uiColor: .label))
            .padding(.horizontal, 30)
            Divider()
                .padding(.horizontal)
            
        }
    }
}
