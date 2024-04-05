//
//  ModelContext+Extensions.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/4.
//

import Foundation
import SwiftData

extension ModelContext {
    
    func inserts<T>(_ models: [T]) where T : PersistentModel {
        guard !models.isEmpty else {
            return
        }
        models.forEach { model in
            insert(model)
        }
    }
    
    func inserts<T>(_ models: T...) where T : PersistentModel {
        guard !models.isEmpty else {
            return
        }
        models.forEach { model in
            insert(model)
        }
    }
}
