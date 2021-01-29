
import Foundation

//MARK: - Practice Sessions Worker
final class PracticeSessionsWorker {
    static let shared = PracticeSessionsWorker()
    
    func loadPracticeSessions(success: @escaping ([PracticeSession]) -> (), failure: @escaping (String) -> ()) {
        PracticeSessionsDataLoader.shared.loadPracticeSessionsData(success: { (sessions) in
            success(sessions)
        }, failure: { (error) in
            failure(error)
        })
    }
}
