import UIKit

class HighscoreTableViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var highscoresLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var serviceHighscores = HighscoresService()
    var records:[Highscore] = []
    
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
        
        for record in highscoresArray {
            records.append(record)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoresTableViewCells", for: indexPath) as? HighscoresTableViewCells {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            
            cell.nameLabel.text = records[indexPath.row].racerName
            cell.dateLabel.text = dateFormatter.string(from: records[indexPath.row].date)
            cell.scoreLabel.text = String(records[indexPath.row].score) + ","
            cell.distanceLabel.text = String(records[indexPath.row].distance) + " м"
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func localizedString() {
        NSLocalizedString("highscores_label", comment: "")
    }
    
}