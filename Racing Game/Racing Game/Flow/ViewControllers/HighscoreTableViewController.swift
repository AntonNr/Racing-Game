import UIKit
import RealmSwift

class HighscoreTableViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var highscoresLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var serviceHighscores = HighscoresService()
    var records: [Highscore] = []
    var recordsSettings: Results<Highscore>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizedString()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadSavedData()
        
        tableView.reloadData()
        
        let rootScreen = UIBarButtonItem(title: NSLocalizedString("back_button", comment: ""), style: .done, target: self, action: #selector(didTapClose))
        navigationItem.leftBarButtonItem = rootScreen
    }

    @objc func didTapClose(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func loadSavedData() {
        
        let highscoresArray = serviceHighscores.getHighscores()
        recordsSettings = highscoresArray
        
        for record in highscoresArray {
            records.append(record)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recordsSettings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoresTableViewCells", for: indexPath) as? HighscoresTableViewCells {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            
            if let record = recordsSettings?[indexPath.row] {
                
                cell.nameLabel.text = record.racerName
                cell.dateLabel.text = dateFormatter.string(from: record.date)
                cell.scoreLabel.text = String(record.score) + ","
                cell.distanceLabel.text = String(record.distance) + " м"
            
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func localizedString() {
        NSLocalizedString("highscores_label", comment: "")
    }
    
}
