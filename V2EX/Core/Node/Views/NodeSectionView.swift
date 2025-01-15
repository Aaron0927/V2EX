//
//  NodeSectionView.swift
//  V2EX
//
//  Created by kim on 2024/12/17.
//

import SwiftUI

struct NodeSectionView: View {
    @Binding var selectedNode: NodeModel?
    @Binding var showDetailView: Bool
    
    let title: String?
    let nodes: [NodeModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .foregroundStyle(Color.theme.title)
                    .font(.title)
                    .bold()
            }
            
            VFlow(alignment: .leading, spacing: 20) {
                ForEach(nodes) { node in
                    NodeRowView(node: node)
                        .onTapGesture {
                            segue(node: node)
                        }
                }
            }
        }
    }
    
    private func segue(node: NodeModel) {
        selectedNode = node
        showDetailView = true
    }
}

#Preview {
    NodeSectionView(selectedNode: .constant(DeveloperPreview.instance.nodeModel), showDetailView: .constant(false), title: "我的关注", nodes: DeveloperPreview.instance.nodes)
}
