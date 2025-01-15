//
//  PorfileRowView.swift
//  V2EX
//
//  Created by kim on 2024/12/19.
//

import SwiftUI

struct ProfileRowView: View {
    
    private let imageName: String
    private let customImageName: String?
    private let title: String
    private let detail: String?
    
    init(imageName: String, customImageName: String? = nil, title: String, detail: String? = nil) {
        self.imageName = imageName
        self.customImageName = customImageName
        self.title = title
        self.detail = detail
    }
    
    var body: some View {
        HStack {
            if let customImageName = customImageName {
                Image(customImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.theme.secondary)
            } else {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.theme.secondary)
            }
            Text(title)
                .font(.body)
                .foregroundStyle(.body)
            Spacer()
            if let detail = detail {
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(Color.theme.caption)
            }
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(Color.theme.caption)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    ProfileRowView(imageName: "shareplay", title: "主题设置")
}
