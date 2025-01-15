//
//  PrivacyView.swift
//  V2EX
//
//  Created by Aaron on 2024/12/24.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        VStack {
            Text("""
                V2EX不会收集您的任何信息，所有的内容都基于V2EX开放API提供。
                     
                这个项目使用了 SwiftUI 构建了一个 V2EX 移动客户端应用。目的是为了学习 SwiftUI 如何开发一个完整的应用。客户端数据基于 V2EX 开放 API。

                项目完全开源，您可用Clone代码，检查代码。

                开源地址: https://github.com/Aaron0927/V2EX
            """)
            .foregroundStyle(Color.theme.body)
            .font(.body)
            .padding(.vertical, 20)
            .background(Color.theme.surface)
            Spacer()
        }
        .background(Color.theme.background)
        .customNavigationBar(title: "隐私政策".localized)
    }
}

#Preview {
    NavigationStack {
        PrivacyView()
    }
}
