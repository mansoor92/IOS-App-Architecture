import Foundation
import Data

final class DependencyContainer {
    
    private let requestModel: RequestModel
    private let defaults = UserDefaults.standard
    private lazy var authRepository = AuthRepositoryFactory.make(requestModel: requestModel)
    private lazy var sessionRepository = SessionRepositoryFactory.make(requestModel: requestModel, defaults: defaults)
    
    init(requestModel: RequestModel) {
        self.requestModel = requestModel
    }
    
    func getAuthRepository() -> AuthRepository { authRepository }
    
    func getSessionRepository() -> SessionRepository { sessionRepository }

    func set(sessionToken: String) {
        sessionRepository = SessionRepositoryFactory.make(requestModel: requestModel, defaults: defaults)
        requestModel.set(sessionHeaders: ["token": sessionToken])
    }
    
    func clearSession() {
        requestModel.set(sessionHeaders: [:])
        sessionRepository.deleteUser()
    }
}
