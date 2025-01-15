//
//  ReplyModel.swift
//  V2EX
//
//  Created by kim on 2024/12/12.
//

import Foundation

// JSON Data
/**
 URL:
 https://www.v2ex.com/api/replies/show.json?topic_id=1096995&page=1&page_size=100
 
 Response:
 {
     "member": {
         "id": 602847,
         "username": "ttkanni",
         "url": "https://www.v2ex.com/u/ttkanni",
         "website": "",
         "twitter": null,
         "psn": null,
         "github": null,
         "btc": null,
         "location": "",
         "tagline": "",
         "bio": "",
         "avatar_mini": "https://cdn.v2ex.com/avatar/b1c9/deca/602847_mini.png?m=1733797042",
         "avatar_normal": "https://cdn.v2ex.com/avatar/b1c9/deca/602847_normal.png?m=1733797042",
         "avatar_large": "https://cdn.v2ex.com/avatar/b1c9/deca/602847_large.png?m=1733797042",
         "avatar_xlarge": "https://cdn.v2ex.com/avatar/b1c9/deca/602847_xlarge.png?m=1733797042",
         "avatar_xxlarge": "https://cdn.v2ex.com/avatar/b1c9/deca/602847_xlarge.png?m=1733797042",
         "avatar_xxxlarge": "https://cdn.v2ex.com/avatar/b1c9/deca/602847_xlarge.png?m=1733797042",
         "created": 1669007467,
         "last_modified": 1733797042
     },
     "created": 1733983641,
     "topic_id": 1096995,
     "content": "没钱创个毛~",
     "content_rendered": "没钱创个毛~",
     "last_modified": 1733983641,
     "member_id": 602847,
     "id": 15659718
 }
 */

struct ReplyModel: Codable, Identifiable {
    let member: MemberModel
    let created, topicID: Int?
    let content, contentRendered: String?
    let lastModified, memberID, id: Int?
}


