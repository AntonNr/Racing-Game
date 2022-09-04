import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var settingsLabel: UILabel!
    @IBOutlet var riderNameLabel: UILabel!
    @IBOutlet var obstacleLabel: UILabel!
    @IBOutlet var carLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var yellowCarButton: UIButton!
    @IBOutlet var greenCarButton: UIButton!
    @IBOutlet var bushButton: UIButton!
    @IBOutlet var coneButton: UIButton!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizedString()
        
        let rootScreen = UIBarButtonItem(title: NSLocalizedString("back_button", comment: ""), style: .done, target: self, action: #selector(didTapClose))
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
    
    func localizedString() {
        saveButton.titleLabel?.text = NSLocalizedString("settings_save_button", comment: "")
        yellowCarButton.titleLabel?.text = NSLocalizedString("settings_yellow_car_button", comment: "")
        greenCarButton.titleLabel?.text = NSLocalizedString("settings_green_car_button", comment: "")
        bushButton.titleLabel?.text = NSLocalizedString("settings_bush_button", comment: "")
        coneButton.titleLabel?.text = NSLocalizedString("settings_cone_button", comment: "")
        settingsLabel.text = NSLocalizedString("settings_label", comment: "")
        riderNameLabel.text = NSLocalizedString("settings_rider_name_label", comment: "")
        carLabel.text = NSLocalizedString("settings_car_label", comment: "")
        obstacleLabel.text = NSLocalizedString("settings_obstacle_type_label", comment: "")
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
