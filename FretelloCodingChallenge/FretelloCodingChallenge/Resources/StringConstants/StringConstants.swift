
import Foundation

enum ApiStringConstants {
    static let url = "http://codingtest.fretello.com:3000/data/sessions.json"
}

enum Errors {
    static let dataError = "error in parsing data"
    static let responseError = "http error"
    static let jsonError = "JSON error:"
}

enum PracticeSessionsCellConstants {
    static let fatalError = "init(coder:) has not been implemented"
    static let date = "Date: "
    static let exerciseId = "Excercise Id: "
    static let exerciseName = "Excercise Name: "
    static let heartRate = "Heart Rate: "
    static let bpm = "Bpm"
    static let practisedAt = "Practiced at:"
    static let sessionName = "Session name:"
    static let practisedDate = "Practice date:"
}

enum PracticeSessionsVCStringConstants {
    static let cellId = "cellId"
    static let fretelloImage = "fretelloImage"
    static let maximumPerformance = "Maximum Practice Performance is "
}
