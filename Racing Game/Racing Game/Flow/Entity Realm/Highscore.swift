import Foundation
import RealmSwift

class Highscore: Object {
    
    @Persisted var racerName: String 
    @Persisted var distance: Double
    @Persisted var score: Int
    @Persisted var date: Date

}
