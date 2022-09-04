import Foundation

class ResultsHighscores: Codable {
    var racerName: String
    var distance: Double
    var score: Int
    var date: Date
    
    init(name: String, date: Date, distance: Double, score: Int ) {
        self.racerName = name
        self.distance = distance
        self.score = score
        self.date = date
    }
}
