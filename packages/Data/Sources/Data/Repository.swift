//
//  Service.swift
//  
//
//  Created by Mansoor Ali on 16/06/2023.
//
import Foundation

/// base class for remote repositories which has requestModel property for network calls
class RemoteRepository {
    
    let requestModel: RequestModel
    
    init(requestModel: RequestModel) {
        self.requestModel = requestModel
    }
}

/// base class for local repositories which has defaults property for persistance storage but we can replace it with core data or another framework according to requirement
class LocalRepository {
    
    let defaults: UserDefaults
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
}

