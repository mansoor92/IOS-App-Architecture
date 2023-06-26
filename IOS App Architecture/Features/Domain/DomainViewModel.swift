//
//  PublicApiInteractor.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 21/06/2023.
//

import Foundation
import Data

protocol DomainViewModelInput {
    func loadDomains(forceRefresh: Bool)
    func count() -> Int
    func item(position: Int) -> Domain
}

protocol DomainViewModelOutput: AnyObject {
    func domainsLoaded()
    func show(error: Error)
}

class DomainViewModel {
    
    private let repository: DomainRepository
    private weak var view: DomainViewModelOutput?
    private var domains = [Domain]()
    
    init(repository: DomainRepository, view: DomainViewModelOutput) {
        self.repository = repository
        self.view = view
    }
}

extension DomainViewModel: DomainViewModelInput {
    
    func loadDomains(forceRefresh: Bool) {
        Task {
            do {
                self.domains = try await repository.getDomains(forceRefresh: forceRefresh, category: "science")
                await MainActor.run {
                    self.view?.domainsLoaded()
                }
            } catch {
                await MainActor.run {
                    self.view?.show(error: error)
                }
            }
        }
    }
    
    func count() -> Int { domains.count }
    
    func item(position: Int) -> Domain { domains[position] }
}
