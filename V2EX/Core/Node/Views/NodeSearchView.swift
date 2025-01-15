//
//  NodeSearchView.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import SwiftUI

struct NodeSearchView: View {
    
    @EnvironmentObject private var vm: NodeViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedNode: NodeModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        // 搜索框
        SearchBarView(searchText: $vm.searchText)
        
        List {
            NodeSectionView(selectedNode: $selectedNode, showDetailView: $showDetailView, title: nil, nodes: vm.allNodes)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationDestination(isPresented: $showDetailView) {
            NodeDetailLoadingView(node: $selectedNode)
        }
    }
}

#Preview {
    NodeSearchView()
        .environmentObject(DeveloperPreview.instance.nodeVM)
}
