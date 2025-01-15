//
//  Node.swift
//  V2EX
//
//  Created by kim on 2024/11/8.
//

import Foundation

// JSON Response
/**
 URL:
 https://www.v2ex.com/api/nodes/all.json
 
 Response:
 {
     "avatar_large": "https://cdn.v2ex.com/navatar/c4ca/4238/1_large.png?m=1700044199",
     "name": "babel",
     "avatar_normal": "https://cdn.v2ex.com/navatar/c4ca/4238/1_normal.png?m=1700044199",
     "title": "Project Babel",
     "url": "https://www.v2ex.com/go/babel",
     "topics": 1123,
     "footer": "",
     "header": "",
     "title_alternative": "Project Babel",
     "avatar_mini": "https://cdn.v2ex.com/navatar/c4ca/4238/1_mini.png?m=1700044199",
     "stars": 411,
     "aliases": [

     ],
     "root": false,
     "id": 1,
     "parent_node_name": "v2ex"
 }
 */

// MARK: - Node
struct NodeModel: Codable, Identifiable, Hashable {
    let avatarLarge: String
    let name: String
    let avatarNormal: String
    let title: String
    let url: String
    let topics: Int
    let footer, header, titleAlternative: String?
    let avatarMini: String
    let stars: Int
    let aliases: [Int]
    let root: Bool
    let id: Int
    let parentNodeName: String?
    
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case avatarLarge = "avatar_large"
        case avatarNormal = "avatar_normal"
        case avatarMini = "avatar_mini"
        case name, title, url, topics
        case footer, header
        case titleAlternative = "title_alternative"
        case stars, aliases, root, id
        case parentNodeName = "parent_node_name"
    }
}
