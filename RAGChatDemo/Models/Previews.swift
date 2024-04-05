//
//  Previews.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/5.
//

import Foundation

protocol Previews {
    
    associatedtype PreviewType
    
    static var previewValue: PreviewType { get }
}
