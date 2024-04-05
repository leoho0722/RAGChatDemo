//
//  ChatCell.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/3.
//

import SwiftUI

struct ChatCell: View {
    
    let contentMessage: String
    
    let isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? .white : .black)
            .background(isCurrentUser ? .blue : Color(.systemGray6))
            .cornerRadius(10)
    }
}

#Preview {
    ChatCell(contentMessage: "This is a single message cell.", 
             isCurrentUser: false)
}
