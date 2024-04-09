//
//  RAG.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/9.
//

import Foundation

struct RAGRequest: Codable {
    
    let question: String
}

struct RAGResponse: Decodable {
    
    let answer: String
}
