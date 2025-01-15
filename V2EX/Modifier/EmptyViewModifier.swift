//
//  EmptyViewModifier.swift
//  V2EX
//
//  Created by Aaron on 2024/11/11.
//

import SwiftUI

struct EmptyViewModifier<T: View>: ViewModifier {
    @Binding var isEmpty: Bool
    @ViewBuilder var emptyView: () -> T

    func body(content: Content) -> some View {
        content
            .overlay {
                emptyView()
                    .opacity(isEmpty ? 1 : 0)
            }
    }
}

extension View {
    func emptyView<Content: View>(isEmpty: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(EmptyViewModifier(isEmpty: isEmpty, emptyView: content))
    }
}

