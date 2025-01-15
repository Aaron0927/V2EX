//
//  TopicListView.swift
//  V2EX
//
//  Created by kim on 2024/12/18.
//

import SwiftUI

struct TopicListView: View {
    
    @Binding var selectedTopic: TopicModel?
    @Binding var showDetailView: Bool
    
    let topics: [TopicModel]
    
    var body: some View {
        ForEach(topics) { topic in
            TopicRowView(topic: topic)
                .onTapGesture {
                    segue(topic: topic)
                }
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
    
    private func segue(topic: TopicModel) {
        selectedTopic = topic
        showDetailView = true
    }
}

#Preview {
    TopicListView(selectedTopic: .constant(nil), showDetailView: .constant(false), topics: [DeveloperPreview.instance.topicModel, DeveloperPreview.instance.topicModel])
}
