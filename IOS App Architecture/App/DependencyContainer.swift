import Foundation
import Data

final class DependencyContainer {
    
    private let requestModel: RequestModel
    private let defaults = UserDefaults.standard
    private lazy var authRepository = AuthRepositoryFactory.make(requestModel: requestModel)
    private lazy var sessionRepository = SessionRepositoryFactory.make(requestModel: requestModel, defaults: defaults)
    private lazy var domainRepository = DomainRepositoryFactory.make(requestModel: requestModel)
    
    init(requestModel: RequestModel) {
        self.requestModel = requestModel
    }
    
    func getAuthRepository() -> AuthRepository { authRepository }
    
    func getSessionRepository() -> SessionRepository { sessionRepository }

    func getDomainRepository() -> DomainRepository { domainRepository }
    
    func set(sessionToken: String) {
        sessionRepository = SessionRepositoryFactory.make(requestModel: requestModel, defaults: defaults)
        requestModel.set(httpAdditionalHeaders: ["token": sessionToken])
    }
    
    func clearSession() {
        requestModel.set(httpAdditionalHeaders: [:])
        sessionRepository.deleteUser()
    }
}
