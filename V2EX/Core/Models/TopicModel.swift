//
//  TopicModel.swift
//  V2EX
//
//  Created by kim on 2024/11/20.
//

import Foundation

/**
 URL:
 https://www.v2ex.com/api/topics/hot.json
 
 Response:
 {
     "node": {
       "avatar_large": "https://cdn.v2ex.com/navatar/c20a/d4d7/12_large.png?m=1650095340",
       "name": "qna",
       "avatar_normal": "https://cdn.v2ex.com/navatar/c20a/d4d7/12_normal.png?m=1650095340",
       "title": "问与答",
       "url": "https://www.v2ex.com/go/qna",
       "topics": 225477,
       "footer": "",
       "header": "一个更好的世界需要你持续地提出好问题。",
       "title_alternative": "Questions and Answers",
       "avatar_mini": "https://cdn.v2ex.com/navatar/c20a/d4d7/12_mini.png?m=1650095340",
       "stars": 4270,
       "aliases": [],
       "root": false,
       "id": 12,
       "parent_node_name": "v2ex"
     },
     "member": {
       "id": 82242,
       "username": "mx3y",
       "url": "https://www.v2ex.com/u/mx3y",
       "website": null,
       "twitter": null,
       "psn": null,
       "github": null,
       "btc": null,
       "location": null,
       "tagline": null,
       "bio": null,
       "avatar_mini": "https://cdn.v2ex.com/avatar/fcb4/b749/82242_mini.png?m=1689670440",
       "avatar_normal": "https://cdn.v2ex.com/avatar/fcb4/b749/82242_normal.png?m=1689670440",
       "avatar_large": "https://cdn.v2ex.com/avatar/fcb4/b749/82242_large.png?m=1689670440",
       "created": 1416278855,
       "last_modified": 1689670440
     },
     "last_reply_by": "znyb",
     "last_touched": 1732065304,
     "title": "求指导，怎样让自己脾气好起来",
     "url": "https://www.v2ex.com/t/1090746",
     "created": 1731985590,
     "deleted": 0,
     "content": "RT\r\n\r\n我开车遇到后面一直按喇叭不停的，会停下来拉对方车门。\r\n晚上大半夜楼下有飙摩托车的，我会跑下去堵人车。\r\n小区物业不作为，我会直接去物业办公室开怼。\r\n公共场所看见有人插队，我会堵住插队人让对方排队。\r\n。。。。。。。。。。。。\r\n这种情况我会经常发生，只要我出门，看见不对的，我就会动起来。。。\r\n这几天看到珠海、成都，今天看到常德的事情，我怂了，我想改改，之前我不认为我有错，现在我也不觉得我这样有错，但是感觉我这种脾气可能哪天就上新闻了，希望改一改。\r\n\r\n求有之前类似情况的 V 友分享下你们脾气改了吗，怎么做到的。",
     "content_rendered": "RT\u003Cbr /\u003E\u003Cbr /\u003E我开车遇到后面一直按喇叭不停的，会停下来拉对方车门。\u003Cbr /\u003E晚上大半夜楼下有飙摩托车的，我会跑下去堵人车。\u003Cbr /\u003E小区物业不作为，我会直接去物业办公室开怼。\u003Cbr /\u003E公共场所看见有人插队，我会堵住插队人让对方排队。\u003Cbr /\u003E。。。。。。。。。。。。\u003Cbr /\u003E这种情况我会经常发生，只要我出门，看见不对的，我就会动起来。。。\u003Cbr /\u003E这几天看到珠海、成都，今天看到常德的事情，我怂了，我想改改，之前我不认为我有错，现在我也不觉得我这样有错，但是感觉我这种脾气可能哪天就上新闻了，希望改一改。\u003Cbr /\u003E\u003Cbr /\u003E求有之前类似情况的 V 友分享下你们脾气改了吗，怎么做到的。",
     "last_modified": 1731985590,
     "replies": 171,
     "id": 1090746
   }
 */

// MARK: - TopicModel - 帖子
struct TopicModel: Identifiable, Codable {
    let node: NodeModel
    let member: MemberModel
    let lastReplyBy: String
    let lastTouched: Double
    let title: String
    let url: String
    let created, lastModified: Double
    let deleted, replies: Int
    let id: Int
    let content: String
    let contentRendered: String
    
    
    enum CodingKeys: String, CodingKey {
        case node, member
        case lastReplyBy = "last_reply_by"
        case lastTouched = "last_touched"
        case title, url, created, deleted, content
        case contentRendered = "content_rendered"
        case lastModified = "last_modified"
        case replies, id
    }
}


