import Foundation

class Results: Codable {
    var racerName: String
    var distance: Double
    var score: Int
    
    init(name: String, distance: Double, score: Int ) {
        self.racerName = name
        self.distance = distance
        self.score = score
    }
}
