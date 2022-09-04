import Foundation
import RealmSwift

class HighscoresService {
    
    var realm = try! Realm()
    
    func saveHighscoresArray(highscoresArray: HighscoresArray) {
        
        try! realm.write({
            self.realm.add(highscoresArray)
        })
        
    }
    
    func getHighscores() -> Results<Highscore> {
        
        let highscores = realm.objects(Highscore.self)
        
        return highscores
    }
    
    func removeHighscore(highscore: Highscore) {
        try! realm.write({
            self.realm.delete(highscore)
        })
    }
    
}
