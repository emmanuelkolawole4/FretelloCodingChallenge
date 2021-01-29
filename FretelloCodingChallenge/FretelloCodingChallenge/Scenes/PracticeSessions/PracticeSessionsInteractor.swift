
import Foundation

//MARK: - Practice Sessions Interactor
final class PracticeSessionsInteractor {
    static let shared = PracticeSessionsInteractor()
    
    func loadPracticeSessions() {
        PracticeSessionsWorker.shared.loadPracticeSessions(success: { (sessions) in
            PracticeSessionsPresenter.shared.presentPracticeSessions(sessions: sessions)
        }, failure: { (error) in
            PracticeSessionsPresenter.shared.presentPracticeSessionsError(prompt: error)
        })
    }
}
