//
//  NetworkConfiguration.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/9.
//

import Foundation

extension NetworkManager {
    
    struct NetworkConfiguration {
        
        static let http = "http://"
        
        static let host = "127.0.0.1:5000"
        
        enum ApiPath: String {
            
            case ragQA = "/rag/qa"
            
            case uploadPDF = "/upload/pdf"
        }
    }
}
