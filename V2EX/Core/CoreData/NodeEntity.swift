//
//  NodeEntity.swift
//  V2EX
//
//  Created by kim on 2024/12/30.
//

import Foundation
import CoreData

@objc(NodeEntity)
public class NodeEntity: NSManagedObject {
    @NSManaged var nodeID: Int32
    @NSManaged var isFavorite: Bool
}
