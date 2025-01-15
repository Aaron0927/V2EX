//
//  NavigationBarModifiler.swift
//  V2EX
//
//  Created by kim on 2024/12/13.
//

import SwiftUI

struct NavigationBarModifiler: ViewModifier {
    @Environment(\.dismiss) var dismiss
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(Color.theme.title)
                    })
                }
            }
    }
}

extension View {
    func customNavigationBar(title: String) -> some View {
        modifier(NavigationBarModifiler(title: title))
    }
}
