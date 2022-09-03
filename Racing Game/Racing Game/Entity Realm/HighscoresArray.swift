import Foundation
import RealmSwift

class HighscoresArray: Object {
    
    @Persisted var highscoresArray: List<Highscore> 
    
}
