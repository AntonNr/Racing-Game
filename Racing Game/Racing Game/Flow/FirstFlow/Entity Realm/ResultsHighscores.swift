import Foundation
import UIKit

final class ResultsHighscores: Codable {
    var racerName: String
    var distance: Double
    var score: Int
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case racerName
        case distance
        case score
        case date
        case avatarIcon
    }
    
    init(name: String, date: Date, distance: Double, score: Int) {
        self.racerName = name
        self.distance = distance
        self.score = score
        self.date = date
    }
    
    func encode(to encoder: Encoder) throws {
        var conteiner = encoder.container(keyedBy: CodingKeys.self)
        try conteiner.encode(racerName, forKey: .racerName)
        try conteiner.encode(distance, forKey: .distance)
        try conteiner.encode(score, forKey: .score)
        try conteiner.encode(date, forKey: .date)
    
    }
    
    init(from decoder: Decoder) throws {
        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.racerName = try conteiner.decode(String.self, forKey: .racerName)
        self.distance = try conteiner.decode(Double.self, forKey: .distance)
        self.score = try conteiner.decode(Int.self, forKey: .score)
        self.date = try conteiner.decode(Date.self, forKey: .date)
        
    }
}
