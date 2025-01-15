//
//  DetailView.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var topic: TopicModel?
    
    var body: some View {
        ZStack {
            if let topic = topic {
                DetailView(topic: topic)
            }
        }
    }
}

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: DetailViewModel
    @State private var isFavorite: Bool = false
    
    @State private var showNodeDetailView: Bool = false
    @State private var selectedNode: NodeModel? = nil
    
    init(topic: TopicModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(topic: topic))
        _selectedNode = State(wrappedValue: topic.node)
        print("Initial DetailView for \(topic.id)")
    }
    
    var body: some View {
        List {
            header
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            Divider()
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Text(vm.topic.content)
                .foregroundStyle(Color.theme.body)
                .font(.body)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            Rectangle()
                .foregroundStyle(Color.theme.border)
                .frame(height: 5)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            // 回复
            replyView
        }
        .listStyle(.plain)
        .customNavigationBar(title: "")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        isFavorite.toggle()
                    }
                }, label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorite ? Color.theme.dager : Color.theme.title)
                })
            }
        }
        .navigationDestination(isPresented: $showNodeDetailView) {
            NodeDetailLoadingView(node: $selectedNode)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(topic: DeveloperPreview.instance.topicModel)
    }
}

extension DetailView {
    private var header: some View {
        HStack(alignment: .top, spacing: 15) {
            UserImageView(member: vm.topic.member)
                .frame(width: 40, height: 40)
                .clipShape(.rect(cornerRadius: 5.0))
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(vm.topic.member.username)
                        .foregroundStyle(Color.theme.secondary)
                        .font(.caption)
                    Spacer()
                    HStack (spacing: 5) {
                        Text("发布于".localized)
                        Text(vm.topic.created.asTimeAgoDisplay())
                    }
                    .foregroundStyle(Color.theme.caption)
                    .font(.caption)
                }
                
                Text(vm.topic.title)
                    .foregroundStyle(Color.theme.body)
                    .font(.body)
                
                HStack(spacing: 15) {
                    IconImageView(imageName: "ellipsis.message", title: "\(vm.topic.replies)")
                        .foregroundStyle(Color.theme.caption)
                    
                    IconImageView(imageName: "clock.arrow.circlepath", title: Date(timeIntervalSince1970: vm.topic.lastTouched).timeAgoDisplay())
                        .foregroundStyle(Color.theme.caption)
                    
                    Spacer()
                    
                    IconImageView(imageName: "newspaper.fill", title: vm.topic.node.name)
                        .foregroundStyle(Color.theme.secondary)
                        .onTapGesture {
                            showNodeDetailView.toggle()
                        }
                }
                .font(.caption)
            }
        }
    }
    
    @ViewBuilder
    private var replyView: some View {
        if vm.replies.isEmpty {
            Text("现在还没有任何回复~".localized)
                .foregroundStyle(Color.theme.caption)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        } else {
            VStack(alignment: .leading, spacing: 10) {
                IconImageView(imageName: "ellipsis.message", title: "最新回复".localized)
                    .foregroundStyle(Color.theme.title)
                    .font(.body)
                
                Divider()
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            
            ForEach(vm.replies) { reply in
                ReplyRowView(reply: reply)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}
