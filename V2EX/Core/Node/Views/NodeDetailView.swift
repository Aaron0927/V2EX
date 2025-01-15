//
//  NodeDetailView.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

struct NodeDetailLoadingView: View {
    
    @Binding var node: NodeModel?
    
    var body: some View {
        ZStack {
            if let node = node {
                NodeDetailView(node: node)
            }
        }
    }
}

struct NodeDetailView: View {
    @StateObject private var vm: NodeDetailViewModel
    
    @State private var selectedTopic: TopicModel? = nil
    @State private var showTopicDetailView: Bool = false
    @State private var selectedTab: Int = 0
    
    init(node: NodeModel) {
        self._vm = StateObject(wrappedValue: NodeDetailViewModel(node: node))
    }
    
    var body: some View {
        List {
            // Header View
            headerView
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            
            Divider()
                .frame(height: 5)
                .overlay(Color.theme.border)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            
            MenuTabView(currentSelected: $selectedTab, titles: ["最新".localized, "所有".localized])
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            
            TopicListView(selectedTopic: $selectedTopic, showDetailView: $showTopicDetailView, topics: vm.allTopics)
        }
        .listStyle(.plain)
        .customNavigationBar(title: "")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.toggleFavorite()
                }, label: {
                    if vm.node.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(Color.theme.dager)
                    } else {
                        Image(systemName: "heart")
                            .foregroundStyle(Color.theme.title)
                    }
                })

            }
        }
        .navigationDestination(isPresented: $showTopicDetailView) {
            DetailLoadingView(topic: $selectedTopic)
        }
    }
    
    private func segue(topic: TopicModel) {
        selectedTopic = topic
        showTopicDetailView = true
    }
}

#Preview {
    NavigationStack {
        NodeDetailView(node: DeveloperPreview.instance.nodeModel)
    }
}

extension NodeDetailView {
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top, spacing: 10) {
                NodeImageView(node: vm.node)
                    .frame(width: 40, height: 40)
                    .clipShape(.rect(cornerRadius: 5))
                VStack(alignment: .leading, spacing: 10) {
                    Text(vm.node.title)
                        .foregroundStyle(Color.theme.body)
                        .font(.headline)
                    HStack(spacing: 15) {
                        IconImageView(imageName: "newspaper", title: "\(vm.node.topics)")
                        IconImageView(imageName: "heart", title: "\(vm.node.stars)")
                        IconImageView(imageName: "link", title: "create")
                    }
                    Text("该节点最近活跃于 xxxx 年 xx 月 xx 日".localized)
                        .foregroundStyle(Color.theme.caption)
                        .font(.caption)
                }
                .foregroundStyle(Color.theme.caption)
                .font(.caption)
                
                Spacer()
            }
            
            Text(vm.node.header ?? "")
                .foregroundStyle(Color.theme.body)
                .font(.body)
            
            Text("节点从 xxxx 年 xx 月 xx 日创建至今".localized)
                .foregroundStyle(Color.theme.caption)
                .font(.footnote)
        }
        .padding(.horizontal, 10)
    }
    
}
