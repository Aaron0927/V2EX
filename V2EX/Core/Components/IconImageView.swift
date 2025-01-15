//
//  IconImageView.swift
//  V2EX
//
//  Created by kim on 2024/11/25.
//

import SwiftUI

struct IconImageView: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: imageName)
            Text(title)
        }
    }
}

#Preview {
    IconImageView(imageName: "ellipsis.message", title: "100")
}
