
import Foundation

final class PracticeSessionsDataLoader { static let shared = PracticeSessionsDataLoader() }

//MARK: - Practice Sessions Data Loader
extension PracticeSessionsDataLoader {
    
    func loadPracticeSessionsData(success: @escaping ([PracticeSession]) -> Void, failure: @escaping (String) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: ApiStringConstants.url) else { return }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print(Errors.dataError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(Errors.responseError)
                return
            }
            
            var practiceSessions: [PracticeSession]?
            do {
                practiceSessions = try JSONDecoder().decode([PracticeSession].self, from: data)
                success(practiceSessions ?? [PracticeSession]())
            } catch {
                print("\(Errors.jsonError) \(error)")
                DispatchQueue.main.async {
                    debugPrint(error)
                    failure(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
}
