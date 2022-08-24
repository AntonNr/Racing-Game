import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let rootScreen = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(didTapClose))
        navigationItem.leftBarButtonItem = rootScreen
    }

    @objc func didTapClose(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didChooseCar(sender: UIButton) {
        let textOfButton = sender.titleLabel?.text
        switch textOfButton {
        case "Yellow":
            UserDefaults.standard.set("Yellow", forKey: "kCar")
        case "Green":
            UserDefaults.standard.set("Green", forKey: "kCar")
        default: break
        }
    }
    
    @IBAction func didChooseObstacle(sender: UIButton) {
        let textOfButton = sender.titleLabel?.text
        switch textOfButton {
        case "Bush":
            UserDefaults.standard.set("Bush", forKey: "kObstacle")
        case "Cone":
            UserDefaults.standard.set("Cone", forKey: "kObstacle")
        default: break
        }
    }
    
    @IBAction func didTapSaveName() {
        UserDefaults.standard.set(textField.text, forKey: UserDefaults.Keys.racerName.rawValue)
        textField.text = ""
    }
}

extension UserDefaults {

    enum Keys: String, CaseIterable {

        case car = "kCar"
        case obstacle = "kObstacle"
        case racerName = "kName"
        case records = "kRecords"

    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }

}
