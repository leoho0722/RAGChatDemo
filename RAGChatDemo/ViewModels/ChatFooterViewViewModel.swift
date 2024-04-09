//
//  ChatFooterViewViewModel.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/3.
//

import SwiftData
import SwiftUI

final class ChatFooterViewViewModel {
    
    func saveChat(context: ModelContext, chat: Chat) throws {
        guard !chat.content.isEmpty else {
            return
        }
        try DatabaseManager.shared.save(context: context, model: chat)
    }
    
    func send(question: String) async throws -> RAGResponse {
        let request = RAGRequest(question: question)
        let result: RAGResponse = try await NetworkManager.shared.requestData(method: .post,
                                                                              path: .ragQA,
                                                                              parameters: request)
        return result
    }
}
