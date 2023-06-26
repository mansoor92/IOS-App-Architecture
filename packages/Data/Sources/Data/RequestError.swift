//
//  File.swift
//  
//
//  Created by Mansoor Ali on 21/06/2023.
//

import Foundation
import ApiClient

extension RequestError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return generic()
        case .badResponse(_, let data, _):
            return String(data: data, encoding: .utf8) ?? generic()
        case .invalidBody(let message):
            print(message)
            return "Invalid Body specified."
        case .invalideQueryParam(let message):
            print(message)
            return "Invalid Query Params specified."
        }
    }
    
    private func generic() -> String {
        return "Looks like something’s gone wrong. If you continue to have issues, you can contact us at ---"
    }
}

extension RequestError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:
            return generic()
        case .badResponse(let code, let data, let response):
            var dict: [String: Any] = [
                "Status Code": code,
                "Body": String(data: data, encoding: .utf8) ?? "\(data.count) bytes"
            ]
            dict["URL"] = response.url
            dict["Headers"] = response.allHeaderFields
            return "<NSHTTPResponse> \(NSDictionary(dictionary: dict))"
        case .invalidBody(let message):
            return "Invalid Body specified \(message)."
        case .invalideQueryParam(let message):
            return "Invalid Query Param \(message)"
        }
    }
}
