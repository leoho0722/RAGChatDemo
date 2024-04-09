//
//  NetworkManager.swift
//  RAGChatDemo
//
//  Created by Leo Ho on 2024/4/9.
//

import Foundation
import SwiftHelpers

final actor NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func requestData<E, D>(method: HTTP.HTTPMethod,
                           path: NetworkConfiguration.ApiPath,
                           parameters: E) async throws -> D where E: Encodable, D: Decodable {
        let urlRequest = try buildURLRequest(method: method, path: path, parameters: parameters)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = (response as? HTTPURLResponse) else {
            throw NetworkError.badResponse
        }
        let statusCode = httpResponse.statusCode
        guard let status = HTTP.HTTPStatus(rawValue: statusCode) else {
            throw NetworkError.unknownStatus(.unknown)
        }
        
        guard status == .ok else {
            throw NetworkError.unexpected(status)
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(D.self, from: data)
            return result
        } catch {
            throw NetworkError.jsonDecodedFailed(error as! DecodingError)
        }
    }
    
    func uploadFile<D>(method: HTTP.HTTPMethod,
                       path: NetworkConfiguration.ApiPath,
                       fileURL: URL) async throws -> D where D: Decodable {
        let urlRequest = try buildUploadFileURLRequest(method: method, path: path)
        let (data, response) = try await URLSession.shared.upload(for: urlRequest, fromFile: fileURL)
        guard let httpResponse = (response as? HTTPURLResponse) else {
            throw NetworkError.badResponse
        }
        let statusCode = httpResponse.statusCode
        guard let status = HTTP.HTTPStatus(rawValue: statusCode) else {
            throw NetworkError.unknownStatus(.unknown)
        }
        
        guard status == .ok else {
            throw NetworkError.unexpected(status)
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(D.self, from: data)
            return result
        } catch {
            throw NetworkError.jsonDecodedFailed(error as! DecodingError)
        }
    }
    
    private func buildURLRequest<E>(method: HTTP.HTTPMethod,
                                    path: NetworkConfiguration.ApiPath,
                                    parameters: E) throws -> URLRequest where E: Encodable {
        let scheme = NetworkConfiguration.http
        let host = NetworkConfiguration.host
        guard let url = URL(string: scheme + host + path.rawValue) else {
            throw NetworkError.badURLFormat
        }
        
        let contentType = HTTP.HTTPHeaderFields.contentType.rawValue
        let json = HTTP.HTTPContentType.json.rawValue
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = [
            contentType : json
        ]
        
        switch method {
        case .get:
            break
        default:
            do {
                urlRequest.httpBody = try JSON.toJsonData(data: parameters)
            } catch {
                throw NetworkError.badRequestJSONBody
            }
        }
        
        return urlRequest
    }
    
    private func buildUploadFileURLRequest(method: HTTP.HTTPMethod,
                                           path: NetworkConfiguration.ApiPath) throws -> URLRequest {
        let scheme = NetworkConfiguration.http
        let host = NetworkConfiguration.host
        guard let url = URL(string: scheme + host + path.rawValue) else {
            throw NetworkError.badURLFormat
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
