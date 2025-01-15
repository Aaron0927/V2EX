//
//  MyTopicView.swift
//  V2EX
//
//  Created by kim on 2024/12/23.
//

import SwiftUI

struct MyTopicView: View {
    
    @StateObject private var vm: MyTopicViewModel
    @State private var selectedTopic: TopicModel? = nil
    @State private var showDetailView: Bool = false
    
    init(member: MemberModel) {
        _vm = StateObject(wrappedValue: MyTopicViewModel(member: member))
    }
    
    var body: some View {
        List {
            TopicListView(selectedTopic: $selectedTopic, showDetailView: $showDetailView, topics: vm.topics)
        }
        .listStyle(.plain)
        .customNavigationBar(title: "我的主题".localized)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundStyle(Color.theme.title)
                }
            }
        }
        .navigationDestination(isPresented: $showDetailView) {
            DetailLoadingView(topic: $selectedTopic)
        }
        
    }
}

#Preview {
    NavigationStack {
        MyTopicView(member: DeveloperPreview.instance.memberModel)
    }
}
