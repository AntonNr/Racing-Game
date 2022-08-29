import UIKit

class HighscoreTableViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var records: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadSavedData()
        
        tableView.reloadData()
        
        let rootScreen = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(didTapClose))
        navigationItem.leftBarButtonItem = rootScreen
    }

    @objc func didTapClose(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func loadSavedData() {
        if let recordsData = UserDefaults.standard.data(forKey: UserDefaults.Keys.records.rawValue) {
            if let recordsResults: [Results] = try? JSONDecoder().decode(Array<Results>.self, from: recordsData) {
                for record in recordsResults {
                    records.append(record)
                }
            }
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
    
}
