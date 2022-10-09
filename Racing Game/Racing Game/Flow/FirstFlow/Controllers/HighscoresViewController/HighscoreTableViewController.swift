import UIKit

class HighscoreTableViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var rootView: HighscoresView!
    
    var highscoresModel = HighscoresModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.localizedString()
        rootView.decorate()
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        highscoresModel.loadSavedData()
        
        rootView.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        highscoresModel.recordsSettings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoresTableViewCells", for: indexPath) as? HighscoresTableViewCells {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            
            if let record = highscoresModel.recordsSettings?[indexPath.row] {
                
                cell.nameLabel.text = record.racerName
                cell.dateLabel.text = dateFormatter.string(from: record.date)
                cell.scoreLabel.text = String(record.score) + ","
                cell.distanceLabel.text = String(record.distance) + " м"
            
            }
            
            cell.backgroundColor = .systemYellow
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}
