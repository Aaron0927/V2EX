//
//  HomeView.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    @State private var isSidebarOpened: Bool = false
    @State private var category: TopicCategory = .hot
    
    @State private var selectedTopic: TopicModel? = nil
    @State private var showDetailView: Bool = false
    
    private let leftViewWidth: CGFloat = 80
    
    var body: some View {
        ZStack(alignment: .leading) {
            contentView
                .frame(maxWidth: .infinity) // 占满全屏
                .offset(x : isSidebarOpened ? leftViewWidth : 0) // 根据状态偏移
                .transition(.move(edge: .trailing))
            
            if isSidebarOpened {
                SidebarView(isSidebarVisible: $isSidebarOpened, category: $category) {
                    print(category)
                    vm.getTopics(category: category)
                }
                .frame(width: leftViewWidth)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isSidebarOpened) // 组件变化时使用的动画
        .onAppear {
            vm.getTopics(category: category)
        }
        .navigationTitle(
            Text(category.rawValue)
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    isSidebarOpened.toggle()
                }, label: {
                    Image(systemName: "list.bullet")
                        .foregroundStyle(Color.theme.title)
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SiteStatView()
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    Image(systemName: "chart.bar")
                        .foregroundStyle(Color.theme.secondary)
                }
            }
        }
        .navigationDestination(isPresented: $showDetailView) {
            DetailLoadingView(topic: $selectedTopic)
                .toolbar(.hidden, for: .tabBar)
        }
    }
    
    private func segue(topic: TopicModel) {
        selectedTopic = topic
        showDetailView = true
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

extension HomeView {
    @ViewBuilder
    private var contentView: some View {
        if vm.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
                .foregroundStyle(Color.theme.secondary)
        }
        if vm.topics.isEmpty {
            VStack(spacing: 15) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.theme.caption)
                    .font(.system(size: 50))
                Text("没有主题数据".localized)
                    .foregroundStyle(Color.theme.caption)
                    .font(.body)
                Button(action: {
                    vm.getTopics(category: category)
                }, label: {
                    Text("刷新".localized)
                        .foregroundStyle(Color.theme.secondary)
                        .font(.body)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 5)
                })
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.theme.secondary, lineWidth: 1.0)
                }
            }
        } else {
            listView
        }
    }
    
    // 列表视图
    private var listView: some View {
        List {
            TopicListView(selectedTopic: $selectedTopic, showDetailView: $showDetailView, topics: vm.topics)
        }
        .listStyle(.plain)
    }
}
