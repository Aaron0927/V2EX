//
//  SearchBarView.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.title)
            
            TextField("搜索节点".localized, text: $searchText)
                .foregroundStyle(Color.theme.title)
                .autocorrectionDisabled(false)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.theme.title)
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
