//
//  CoreDataManager.swift
//  V2EX
//
//  Created by kim on 2024/12/27.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    private let containerName: String = "V2EXContainer"
    private let nodeEntityName: String = "NodeEntity"
    
    
    @Published var nodeEntities: [NodeEntity] = []
    
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
        
        let storeURL = container.persistentStoreDescriptions.first!.url!
    }
    
    // Save context
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch let error {
                print("Error saving Entity, \(error)")
            }
        }
    }
}

// MARK: - NodeEntity
extension CoreDataManager {
    
    func updateNode(node: NodeModel, isFavorite: Bool) {
        if let entity = nodeEntities.first(where: { $0.nodeID == node.id }) {
            isFavorite ? update(entity: entity, isFavorite: isFavorite) : delete(entity: entity)
        } else {
            add(node: node, isFavorite: isFavorite)
        }
    }
    
    // 获取全部
    func getAllNodes() {
        let request = NSFetchRequest<NodeEntity>(entityName: nodeEntityName)
        do {
            self.nodeEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching All Node Entities. \(error)")
            self.nodeEntities = []
        }
    }
    
    // 添加数据
    private func add(node: NodeModel, isFavorite: Bool) {
        let entity = NodeEntity(context: container.viewContext)
        entity.nodeID = Int32(node.id)
        entity.isFavorite = isFavorite
        applyNodeEntityChanges()
    }
    
    
    // 删除数据
    private func delete(entity: NodeEntity) {
        container.viewContext.delete(entity)
        applyNodeEntityChanges()
    }
    
    // 更新数据
    private func update(entity: NodeEntity, isFavorite: Bool) {
        entity.isFavorite = isFavorite
        applyNodeEntityChanges()
    }
    
    private func applyNodeEntityChanges() {
        saveContext()
        getAllNodes()
    }
}
