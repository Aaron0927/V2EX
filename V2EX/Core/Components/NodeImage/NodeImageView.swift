//
//  NodeImageView.swift
//  V2EX
//
//  Created by kim on 2024/12/18.
//

import SwiftUI

struct NodeImageView: View {
    
    @StateObject var vm: NodeImageViewModel
    
    init(node: NodeModel) {
        _vm = StateObject(wrappedValue: NodeImageViewModel(node: node))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.nodeImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}

#Preview {
    NodeImageView(node: DeveloperPreview.instance.nodeModel)
}
