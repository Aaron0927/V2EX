//
//  NodeRowView.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import SwiftUI

struct NodeRowView: View {
    
    var node: NodeModel
    
    var body: some View {
        Text(node.title)
            .foregroundStyle(Color.theme.secondary)
            .font(.body)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.theme.border, lineWidth: 1)
            )
    }
}

#Preview {
    NodeRowView(node: DeveloperPreview.instance.nodeModel)
}
