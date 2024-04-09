//
//  NetworkError.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/9.
//

import Foundation
import SwiftHelpers

extension NetworkManager {
    
    enum NetworkError: Error {
        
        /// 錯誤的 URL 格式
        case badURLFormat
        
        /// 錯誤的 URLRequest Body
        case badRequestJSONBody
        
        /// 錯誤的 HTTP Response
        case badResponse
        
        /// 無預期的 HTTP Status
        case unexpected(HTTP.HTTPStatus)
        
        /// 未知的 HTTP Status
        case unknownStatus(HTTP.HTTPStatus)
        
        /// JSON 解碼失敗
        case jsonDecodedFailed(DecodingError)
    }
}
