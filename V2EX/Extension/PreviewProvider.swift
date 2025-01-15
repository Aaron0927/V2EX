//
//  PreviewProvider.swift
//  V2EX
//
//  Created by kim on 2024/11/20.
//

import Foundation
import SwiftUI

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let homeVM = HomeViewModel()
    
    let nodeVM = NodeViewModel()
    
    let notifyVM = NotificationViewModel()
    
    lazy var memberModel: MemberModel = {
        MemberModel(
            id: 82242,
            username: "mx3y",
            url: "https://www.v2ex.com/u/mx3y",
            website: nil,
            twitter: nil,
            psn: nil,
            github: nil,
            btc: nil,
            location: nil,
            tagline: nil,
            bio: nil,
            avatarMini: "https://cdn.v2ex.com/avatar/fcb4/b749/82242_mini.png?m=1689670440",
            avatarNormal: "https://cdn.v2ex.com/avatar/fcb4/b749/82242_normal.png?m=1689670440",
            avatarLarge: "https://cdn.v2ex.com/avatar/fcb4/b749/82242_large.png?m=1689670440",
            created: 1416278855,
            lastModified: 1689670440,
            status: "found"
        )
    }()
    
    lazy var nodeModel: NodeModel = {
        NodeModel(
            avatarLarge: "https://cdn.v2ex.com/navatar/c20a/d4d7/12_large.png?m=1650095340",
            name: "qna",
            avatarNormal: "https://cdn.v2ex.com/navatar/c20a/d4d7/12_normal.png?m=1650095340",
            title: "问与答",
            url: "https://www.v2ex.com/go/qna",
            topics: 225477,
            footer: "",
            header: "一个更好的世界需要你持续地提出好问题。",
            titleAlternative: "Questions and Answers",
            avatarMini: "https://cdn.v2ex.com/navatar/c20a/d4d7/12_mini.png?m=1650095340",
            stars: 4270,
            aliases: [],
            root: false,
            id: 12,
            parentNodeName: "v2ex"
        )
    }()
    
    lazy var topicModel: TopicModel = {
        TopicModel(
            node: nodeModel,
            member: memberModel,
            lastReplyBy: "znyb", 
            lastTouched: 1732065304,
            title: "求指导，怎样让自己脾气好起来",
            url: "https://www.v2ex.com/t/1090746",
            created: 1731985590,
            lastModified: 1731985590,
            deleted: 0,
            replies: 171,
            id: 1090746,
            content: "RT\r\n\r\n我开车遇到后面一直按喇叭不停的，会停下来拉对方车门。\r\n晚上大半夜楼下有飙摩托车的，我会跑下去堵人车。\r\n小区物业不作为，我会直接去物业办公室开怼。\r\n公共场所看见有人插队，我会堵住插队人让对方排队。\r\n。。。。。。。。。。。。\r\n这种情况我会经常发生，只要我出门，看见不对的，我就会动起来。。。\r\n这几天看到珠海、成都，今天看到常德的事情，我怂了，我想改改，之前我不认为我有错，现在我也不觉得我这样有错，但是感觉我这种脾气可能哪天就上新闻了，希望改一改。\r\n\r\n求有之前类似情况的 V 友分享下你们脾气改了吗，怎么做到的。",
            contentRendered: ""
        )
    }()
    
    lazy var nodes: [NodeModel] = {
        return [
            nodeModel,
            NodeModel(avatarLarge: "https://cdn.v2ex.com/navatar/c4ca/4238/1_large.png?m=1700044199", name: "babel", avatarNormal: "https://cdn.v2ex.com/navatar/c4ca/4238/1_normal.png?m=1700044199", title: "Project Babel", url: "https://www.v2ex.com/go/babel", topics: 1123, footer: "", header: "", titleAlternative: "Project Babel", avatarMini: "https://cdn.v2ex.com/navatar/c4ca/4238/1_mini.png?m=1700044199", stars: 411, aliases: [], root: false, id: 1, parentNodeName: "v2ex"),
            NodeModel(avatarLarge: "https://cdn.v2ex.com/navatar/e4da/3b7f/5_large.png?m=1584385880", name: "movie", avatarNormal: "https://cdn.v2ex.com/navatar/e4da/3b7f/5_normal.png?m=1584385880", title: "电影", url: "https://www.v2ex.com/go/movie", topics: 1379, footer: "", header: "用 90 分钟去体验另外一个世界。", titleAlternative: "Movie", avatarMini: "https://cdn.v2ex.com/navatar/e4da/3b7f/5_mini.png?m=1584385880", stars: 2088, aliases: [], root: false, id: 5, parentNodeName: "life"),
        ]
    }()
    
    lazy var notificationModel: NotificationModel = {
        NotificationModel(
            id: 24084148,
            memberID: 10131,
            forMemberID: 629868,
            text: "<a href=\"/member/lidashuang\"><strong>lidashuang</strong></a> 在 <a href=\"/t/1093077#reply5\" class=\"topic-link\">学习 Django 还有必要吗</a> 里回复了你",
            payload: "可以试试 rails https://ruby-china.org/topics/43935\r\nRuby 三年后，仍在热爱 Ruby",
            payloadRendered: "可以试试 rails <a target=\"_blank\" href=\"https://ruby-china.org/topics/43935\" rel=\"nofollow noopener\">https://ruby-china.org/topics/43935</a><br />Ruby 三年后，仍在热爱 Ruby",
            created: 1732689217
//            member: memberModel
        )
    }()
    
    lazy var replyModel: ReplyModel = {
        ReplyModel(
            member: memberModel,
            created: 1733983641,
            topicID: 1096995,
            content: "没钱创个毛~",
            contentRendered: "没钱创个毛~",
            lastModified: 1733983641,
            memberID: 602847,
            id: 15659718
        )
    }()
}
