//
//  RequestModel.swift
//
//
//  Created by Mansoor Ali on 16/06/2023.
//

import Foundation
import ApiClient

/// RequestModel is used for managing network layer.
///
/// You can manage HTTPClient, JSONDecoder and URLRequestEncoder strategy here
///
/// Also we manage session headers which are httpAdditionalHeaders that are sent with each request for example you can set "token" header as sessionHeader which is then sent in each request after user has logged in
public class RequestModel {

    private let client: HTTPClient
    private let decoder = JSONDecoder()
    private let requestEncoder = DefaultURLRequestEncoder(jsonEncoder: JSONEncoder())
    
    public init(baseURL: URL) {
        client = HTTPClient(config: URLSessionConfiguration.default, baseURL: baseURL)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // use this run method when you want the library to automatically decode response
    func run<T: Decodable>(endpoint: EndPoint, overrideBaseURL: URL? = nil) async throws -> T {
        let response: Response<T> = try await client.run(endpoint: endpoint, requestEncoder: requestEncoder, decoder: decoder, overrideBaseURL: overrideBaseURL)
        return response.value
    }
    
    // use raw data when you want to customize decoder
    /*
    func run<T: Decodable>(endpoint: EndPoint, overrideBaseURL: URL? = nil) async throws -> T {
        let response = try await client.run(endpoint: endpoint, requestEncoder: requestEncoder, overrideBaseURL: overrideBaseURL)
        let httpResponse = response.response as! HTTPURLResponse
        let wrappedResponse = try decoder.decode(ResponseWrapper<T>.self, from: response.value)
        if let value = wrappedResponse.value {
             return value
        } else if let error = wrappedResponse.errors.first, let errorData = error.data(using: .utf8){
            throw RequestError.badResponse(httpResponse.statusCode, errorData, httpResponse)
        } else {
            throw RequestError.unknown
        }
    }*/
    
    /// httpAdditionalHeaders are sent with each request
    public func set(httpAdditionalHeaders: [String:String]) {
        client.set(sessionHeaders: httpAdditionalHeaders)
    }
}

