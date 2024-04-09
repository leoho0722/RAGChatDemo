//
//  DatabaseManager.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/9.
//

import Foundation
import SwiftData

final class DatabaseManager: NSObject {
    
    static let shared = DatabaseManager()
    
    func save<T>(context: ModelContext, model: T) throws where T: PersistentModel {
        context.insert(model)
    }
}
