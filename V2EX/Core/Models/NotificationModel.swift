//
//  NotificationModel.swift
//  V2EX
//
//  Created by kim on 2024/11/26.
//

import Foundation

/**
 URL:
 GET https://www.v2ex.com/api/v2/notifications?p=2
 Authorization: Bearer 0d023c5a-442c-4bc6-9084-30db95d111f1
 
 Response:
 {
     "id": 24084148,
     "member_id": 10131,
     "for_member_id": 629868,
     "text": "<a href=\"/member/lidashuang\"><strong>lidashuang</strong></a> 在 <a href=\"/t/1093077#reply5\" class=\"topic-link\">学习 Django 还有必要吗</a> 里回复了你",
     "payload": "可以试试 rails https://ruby-china.org/topics/43935\r\nRuby 三年后，仍在热爱 Ruby",
     "payload_rendered": "可以试试 rails <a target=\"_blank\" href=\"https://ruby-china.org/topics/43935\" rel=\"nofollow noopener\">https://ruby-china.org/topics/43935</a><br />Ruby 三年后，仍在热爱 Ruby",
     "created": 1732689217,
     "member": {
         "username": "lidashuang"
     }
 }
 */

// MARK: - NotificationModel
struct NotificationModel: Identifiable, Codable {
    let id: Int
    let memberID, forMemberID: Int?
    let text: String
    let payload, payloadRendered: String?
    let created: Double
//    let member: MemberModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case memberID = "member_id"
        case forMemberID = "for_member_id"
        case text
        case payload
        case payloadRendered = "payload_rendered"
        case created
//        case member
    }
}

struct NotificationResult: Codable {
    let success: Bool
    let message: String
    let result: [NotificationModel]
}

