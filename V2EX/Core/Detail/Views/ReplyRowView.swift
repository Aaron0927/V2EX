//
//  ReplyRowView.swift
//  V2EX
//
//  Created by Aaron on 2024/12/12.
//

import SwiftUI

struct ReplyRowView: View {
    
    let reply: ReplyModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 15) {
                UserImageView(member: reply.member)
                    .frame(width: 40, height: 40)
                    .clipShape(.rect(cornerRadius: 5))
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(reply.member.username)
                            .foregroundStyle(Color.theme.secondary)
                            .font(.caption)
                        Spacer()
                        IconImageView(imageName: "clock.arrow.circlepath", title: String(format: "回复于 %@".localized, Double(reply.lastModified ?? 0).asTimeAgoDisplay()))
                            .foregroundStyle(Color.theme.caption)
                            .font(.caption)
                    }
                    .padding(.top, 5)
                    
                    Text(reply.content ?? "")
                        .foregroundStyle(Color.theme.body)
                        .font(.body)
                }
            }
            .padding(.top, 10)
            Divider()
                .padding(.top, 10)
        }
    }
}

#Preview {
    ReplyRowView(reply: DeveloperPreview.instance.replyModel)
}
