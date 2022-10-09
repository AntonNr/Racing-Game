import Foundation
import RealmSwift

class HighscoresModel {
    
    var serviceHighscores = HighscoresService()
    var records: [Highscore] = []
    var recordsSettings: Results<Highscore>?
    
    func loadSavedData() {
        
        let highscoresArray = serviceHighscores.getHighscores()
        recordsSettings = highscoresArray
        
        for record in highscoresArray {
            records.append(record)
        }
    }
}
