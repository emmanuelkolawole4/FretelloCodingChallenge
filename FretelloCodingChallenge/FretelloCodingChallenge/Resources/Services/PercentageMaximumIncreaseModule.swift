
import Foundation

final class PercentageMaximumIncrease { static let shared = PercentageMaximumIncrease() }
    
extension PercentageMaximumIncrease {
    
    func getMaximumAverage (of sessions: [[Int]]) -> Int {
        var averages = [Double]()
        var average: Double = 0.0
        var highest: Double = 0.0
        var percentageValue: Double = 0.0
        var highestValues = [Double]()
        var percentageAverages = [Double]()
        
        for session in sessions {
            for _ in session {
                var sum: Double = 0.0
                for item in session {
                    sum += Double(item)
                }
                average = sum / Double(session.count)
            }
            averages.append(average)
        }
        
        for session in sessions.dropFirst() {
            for _ in session.dropFirst() {
                highest = Double(session.max() ?? Int())
            }
            highestValues.append(highest)
        }
        
        for (index, highest) in highestValues.enumerated() {
            percentageValue = highest * 100 / averages[index]
            percentageAverages.append(percentageValue)
        }
        return Int(percentageAverages.max() ?? Double(Int()))
    }
    
}
