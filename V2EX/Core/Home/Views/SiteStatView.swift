//
//  SiteStatView.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

struct SiteStatView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: SiteStatViewModel = SiteStatViewModel()
    
    var body: some View {
        List {
            HStack(spacing: 20) {
                Text("注册会员".localized)
                    .foregroundStyle(Color.theme.body)
                Text("\(vm.stat.memberMax)")
                    .foregroundStyle(Color.theme.caption)
            }
            HStack(spacing: 20) {
                Text("主题数量".localized)
                    .foregroundStyle(Color.theme.body)
                Text("\(vm.stat.topicMax)")
                    .foregroundStyle(Color.theme.caption)
            }
        }
        .listStyle(.plain)
        .font(.body)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .background(Color.theme.background)
        .customNavigationBar(title: "V2EX统计".localized)
    }
}

#Preview {
    NavigationStack {
        SiteStatView()
    }
}
