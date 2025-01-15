//
//  CustomTabView.swift
//  V2EX
//
//  Created by kim on 2024/12/30.
//

import SwiftUI

struct MenuTabView: View {
    
    @Namespace var animationNamespace
    @Binding var currentSelected: Int
    @State private var scrollEnabled: Bool = false
    
    private let geometryID: String = "slider_rectangle"
    var titles: [String]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(alignment: .top) {
                        ForEach(titles.indices, id: \.self) { index in
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    currentSelected = index
                                    proxy.scrollTo(index, anchor: .center)
                                }
                            }, label: {
                                VStack {
                                    Text(titles[index])
                                        .foregroundStyle(currentSelected == index ? Color.theme.secondary : Color.theme.title)
                                        .font(.body)
                                    if currentSelected == index {
                                        Rectangle()
                                            .frame(width: 40, height: 3)
                                            .clipShape(.rect(cornerRadius: 10 ))
                                            .foregroundStyle(Color.theme.secondary)
                                            .matchedGeometryEffect(id: geometryID, in: animationNamespace)
                                    }
                                }
                                .frame(minWidth: 40)
                                .padding(.horizontal, 5)
                            })
                        }
                    }
                    .padding(6)
                    .background(
                        GeometryReader { contentGeometry in
                            Color.clear
                                .onAppear {
                                    if contentGeometry.size.width <= geometry.size.width {
                                        scrollEnabled = false
                                    } else {
                                        scrollEnabled = true
                                    }
                                }
                        }
                    )
                }
                .scrollIndicators(.hidden)
                .scrollDisabled(!scrollEnabled)
            }
            
        }
        .frame(height: 40)
    }
}

#Preview {
    MenuTabView(currentSelected: .constant(1), titles: ["讨论", "资金", "资讯", "公告"])
}
