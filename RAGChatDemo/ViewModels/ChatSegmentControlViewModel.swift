//
//  ChatSegmentControlViewModel.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/5.
//

import Foundation
import SwiftHelpers

final class ChatSegmentControlViewModel {
    
    var chatInputMethodOptions: [ChatSegmentControlItem] {
        AppDefine.ChatInputMethod.allCases.map { method in
            ChatSegmentControlItem(title: method.rawValue.title, symbols: method.rawValue.symbols)
        }
    }
}
