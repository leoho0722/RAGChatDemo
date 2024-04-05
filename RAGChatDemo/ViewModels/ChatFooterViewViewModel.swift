//
//  ChatFooterViewViewModel.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/3.
//

import SwiftData
import SwiftUI

final class ChatFooterViewViewModel {
    
    func sendChat(context: ModelContext, chatMessage: String) {
        guard !chatMessage.isEmpty else {
            return
        }
        
        let newChat = Chat(content: chatMessage, isReply: true)
        let replyChat = Chat(content: "Reply of \(chatMessage)", isReply: false)
        context.inserts(newChat, replyChat)
    }
}
