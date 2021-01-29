
import Foundation

//MARK: - Practice Sessions Presenter
final class PracticeSessionsPresenter {
    static let shared = PracticeSessionsPresenter()
    var practiceSessionsView: PracticeSessionsDisplayLogic?
    
    func presentPracticeSessions(sessions: [PracticeSession]) {
        practiceSessionsView?.displayPracticeSessions(sessions: sessions)
    }
    
    func presentPracticeSessionsError(prompt: String) {
        practiceSessionsView?.displayPracticeSessionsError(prompt: prompt)
    }
}
