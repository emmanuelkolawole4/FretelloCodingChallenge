
import Foundation

struct PracticeSession: Codable {
    let name: String
    let practicedOnDate: String
    let exercises: [Exercise]
}

struct Exercise: Codable {
    let exerciseId: String
    let name: String
    let practicedAtBpm: Int
}
