//
//  TopicRowView.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import SwiftUI

struct TopicRowView: View {
    
    @State private var showNodeDetailView: Bool = false
    @State private var selectedNode: NodeModel?
    
    var topic: TopicModel
    
    init(topic: TopicModel) {
        self._selectedNode = State(wrappedValue: topic.node)
        self.topic = topic
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 15) {
                UserImageView(member: topic.member)
                    .frame(width: 40, height: 40)
                    .clipShape(.rect(cornerRadius: 5))
                
                VStack(alignment: .leading, spacing: 8) {
                    topView
                    
                    centerView
                    
                    bottomView
                }
            }
            Divider()
        }
        .padding(.horizontal, 10)
        .padding(.top, 15)
        .navigationDestination(isPresented: $showNodeDetailView) {
            NodeDetailLoadingView(node: $selectedNode)
        }
    }
}

#Preview {
    TopicRowView(topic: DeveloperPreview.instance.topicModel)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
}

#Preview {
    TopicRowView(topic: DeveloperPreview.instance.topicModel)
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
}

extension TopicRowView {
    var topView: some View {
        HStack {
            Text(topic.member.username)
                .foregroundStyle(Color.theme.secondary)
                .font(.caption)
            Spacer()
            HStack (spacing: 5) {
                Text("发布于".localized)
                Text(Date(timeIntervalSince1970: topic.created).timeAgoDisplay())
            }
            .foregroundStyle(Color.theme.caption)
            .font(.caption)
        }
    }
    
    var centerView: some View {
        Text(topic.title)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.theme.body)
            .font(.body)
    }
    
    var bottomView: some View {
        HStack {
            HStack(spacing: 15) {
                IconImageView(imageName: "person.wave.2.fill", title: topic.lastReplyBy)
                .foregroundStyle(Color.theme.secondary)
                
                IconImageView(imageName: "ellipsis.message", title: "\(topic.replies)")
                .foregroundStyle(Color.theme.caption)
                
                IconImageView(imageName: "clock.arrow.circlepath", title: Date(timeIntervalSince1970: topic.lastTouched).timeAgoDisplay())
                .foregroundStyle(Color.theme.caption)
            }
            Spacer()
            IconImageView(imageName: "newspaper.fill", title: topic.node.name)
            .foregroundStyle(Color.theme.secondary)
            .onTapGesture {
                showNodeDetailView.toggle()
            }
        }
        .font(.caption)
        .lineLimit(1)
        .padding(.bottom, 5)
    }
}
