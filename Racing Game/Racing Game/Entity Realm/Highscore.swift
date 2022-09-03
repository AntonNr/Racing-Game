import Foundation
import RealmSwift

class Highscore: Object {
    
    @Persisted var racerName: String 
    @Persisted var distance: Double
    @Persisted var score: Int
    @Persisted var date: Date
    
    init(name: String, date: Date, distance: Double, score: Int ) {
        self.racerName = name
        self.distance = distance
        self.score = score
        self.date = date
    }
}
