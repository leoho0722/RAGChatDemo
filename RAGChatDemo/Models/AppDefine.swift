//
//  AppDefine.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/5.
//

import Foundation
import SwiftHelpers

struct AppDefine {
    
    enum ChatInputMethod: Identifiable, CaseIterable, RawRepresentable {
        
        case text
        
        case voice
        
        init?(rawValue: ChatSegmentControlItem) {
            switch rawValue.symbols {
            case .keyboard:
                self = .text
            case .musicMic:
                self = .voice
            default:
                fatalError("Unknown ChatInputMethod type")
            }
        }
        
        var id: Self { self }
        
        var rawValue: ChatSegmentControlItem {
            switch self {
            case .text:
                return ChatSegmentControlItem(title: "Text", symbols: .keyboard)
            case .voice:
                return ChatSegmentControlItem(title: "Voice", symbols: .musicMic)
            }
        }
    }
}
