//
//  NotifcationRowView.swift
//  V2EX
//
//  Created by Aaron on 2024/11/10.
//

import SwiftUI

struct NotifcationRowView: View {
    
    @EnvironmentObject private var appState: AppState
    var notification: NotificationModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 15) {
                if let member = appState.member {
                    UserImageView(member: member)
                        .frame(width: 40, height: 40)
                        .clipShape(.rect(cornerRadius: 5))
                } else {
                    Rectangle()
                        .background(Color.red)
                        .frame(width: 40, height: 40)
                        .clipShape(.rect(cornerRadius: 5))
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    markdownView
                        
                    if let payload = notification.payload {
                        Text(payload)
                            .foregroundStyle(Color.theme.body)
                            .font(.body)
                    }
                    HStack {
                        Text(notification.created.asTimeAgoDisplay())
                        Spacer()
                        Image(systemName: "ellipsis")
                    }
                    .font(.caption)
                    .foregroundStyle(.caption)
                }
            }
            
            Divider()
                .foregroundStyle(Color.theme.border)
        }
        .padding(.horizontal, 10)
        .padding(.top, 15)
        .padding(.bottom, 5)
    }
}

#Preview {
    NotifcationRowView(notification: DeveloperPreview.instance.notificationModel)
        .previewLayout(.sizeThatFits)
        .environmentObject(AppState())
}

extension NotifcationRowView {
    
    private var markdownView: some View {
        let topic = notification.text.convertHTMLToAttributedString()
        return Text(topic)
            .foregroundStyle(Color.theme.body)
            .font(.body)
    }
}
