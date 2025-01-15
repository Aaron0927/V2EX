//
//  NodeView.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

struct NodeView: View {
    @StateObject private var vm: NodeViewModel = NodeViewModel()
    @State private var showSheet: Bool = false
    @State private var selectedNode: NodeModel? = nil
    @State private var showDetailView: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(vm.sectionNodes.keys.sorted(), id:\.self) { key in
                        NodeSectionView(selectedNode: $selectedNode, showDetailView: $showDetailView, title: key.capitalized, nodes: vm.sectionNodes[key] ?? [])
                        Divider()
                            .frame(height: 5)
                            .background(Color.theme.background)
                            .padding(.vertical, 10)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .navigationTitle("节点".localized)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showDetailView, destination: {
                NodeDetailLoadingView(node: $selectedNode)
                    .toolbar(.hidden, for: .tabBar)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.theme.title)
                    })
                }
            }
            .sheet(isPresented: $showSheet, content: {
                NodeSearchView()
            })
            .environmentObject(vm)
        }
    }
}

#Preview {
    NavigationStack {
        NodeView()
    }
}
