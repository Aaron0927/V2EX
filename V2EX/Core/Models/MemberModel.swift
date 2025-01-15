//
//  MemberModel.swift
//  V2EX
//
//  Created by kim on 2024/12/18.
//

import Foundation

// JSON Response
/**
 URL：
 https://www.v2ex.com/api/members/show.json?username=mx3y
 
 Response:
 {
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
     "last_modified": 1689670440,
     "status": "found"
 }
 */

// MARK: - Member
struct MemberModel: Codable {
    let id: Int
    let username: String
    let url: String
    let website, twitter, psn, github: String?
    let btc, location, tagline, bio: String?
    let avatarMini, avatarNormal, avatarLarge: String
    let created, lastModified: Int
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id, username, url, website, twitter, psn, github, btc, location, tagline, bio, created, status
        case avatarMini = "avatar_mini"
        case avatarNormal = "avatar_normal"
        case avatarLarge = "avatar_large"
        case lastModified = "last_modified"
    }
}

struct MemberModelWrapper: Codable {
    let success: Bool
    let member: MemberModel
    
    enum CodingKeys: String, CodingKey {
        case success
        case member = "result"
    }
}
