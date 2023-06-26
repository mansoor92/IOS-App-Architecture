//
//  File.swift
//  
//
//  Created by Mansoor Ali on 21/06/2023.
//

import Foundation
import ApiClient

public protocol DomainRepository {
    func getDomains(forceRefresh: Bool, category: String) async throws -> [Domain]
}

public class DomainRepositoryFactory {
    public static func make(requestModel: RequestModel) -> DomainRepository {
        return DomainRemoteRepository(requestModel: requestModel)
    }
}

class DomainRemoteRepository: RemoteRepository, DomainRepository {
    
    private var domainList = DomainList(count: 0, entries: [])
    private var category = ""
    
    func getDomains(forceRefresh: Bool, category: String) async throws -> [Domain] {
        guard forceRefresh || domainList.entries.isEmpty || category != self.category else { return domainList.entries }
        domainList = try await requestModel.run(endpoint: EndPoint(method: .get, path: "/entries", contentType: .json, queryItems: ["category":category]))
        return domainList.entries
    }
}
