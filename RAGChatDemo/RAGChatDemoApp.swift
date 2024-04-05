//
//  RAGChatDemoApp.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/3.
//

import SwiftData
import SwiftUI

@main
struct RAGChatDemoApp: App {
    
    var body: some Scene {
        WindowGroup {
            RAGChatView()
                .modelContainer(for: [Chat.self])
        }
    }
}
