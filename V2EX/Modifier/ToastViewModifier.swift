//
//  ToastViewModifier.swift
//  V2EX
//
//  Created by kim on 2025/1/15.
//

import SwiftUI

struct ToastView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .transition(.slide)
            .animation(.easeInOut, value: message)
            .padding(.bottom, 50)
    }
}

struct ToastViewModifier: ViewModifier {
    var message: String
    @Binding var showToast: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if showToast {
                ToastView(message: message)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                    }
            }
        }
    }
}

extension View {
    func toast(_ message: String, showToast: Binding<Bool>) -> some View {
        modifier(ToastViewModifier(message: message, showToast: showToast))
    }
}


