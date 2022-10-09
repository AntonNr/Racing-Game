import Foundation
import UIKit

class HighscoresView: UIView {
    
    @IBOutlet var highscoresLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    func decorate() {
        
        backgroundColor = .systemYellow
        tableView.backgroundColor = .systemYellow
        
    }
    
    func localizedString() {
        highscoresLabel.text = NSLocalizedString("highscores_label", comment: "")
    }
}
