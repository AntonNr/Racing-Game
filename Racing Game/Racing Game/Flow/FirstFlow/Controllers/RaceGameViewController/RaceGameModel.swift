import Foundation

class RaceGameModel {
    
    var serviceHighscores = HighscoresService()
    
    func saveRecordRealm(distance: Double, score: Int) {
        
        let currentRecord: Highscore = Highscore()
        currentRecord.racerName = UserDefaults.standard.object(forKey: UserDefaults.Keys.racerName.rawValue) as? String ?? "Player"
        currentRecord.date = Date()
        currentRecord.distance = distance
        currentRecord.score = score
        
        let recordArray = HighscoresArray()
        recordArray.highscoresArray.append(currentRecord)
        
        serviceHighscores.saveHighscoresArray(highscoresArray: recordArray)
        
    }
    
    func saveRecordUserDefaults(distance: Double, score: Int) {
        var records: [ResultsHighscores] = []
        
        if let recordsData = UserDefaults.standard.data(forKey: UserDefaults.Keys.records.rawValue) {
            if let oldRecords: [ResultsHighscores] = try? JSONDecoder().decode(Array<ResultsHighscores>.self, from: recordsData) {
                records = oldRecords
            }
        }
        
        let currentRecord = ResultsHighscores(name: UserDefaults.standard.object(forKey: UserDefaults.Keys.racerName.rawValue) as? String ?? "Player", date: Date(), distance: distance, score: score)
        
        records.append(currentRecord)
        let recordsData = try? JSONEncoder().encode(records)
        UserDefaults.standard.set(recordsData, forKey: UserDefaults.Keys.records.rawValue)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        print(dateFormatter.string(from: currentRecord.date))
    }
}
