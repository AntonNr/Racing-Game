import UIKit
import RealmSwift

class SettingsViewController: UIViewController {
    
    @IBOutlet var rootView: SettingsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.localizedStrings()
        rootView.decorate()
        
        let carColor = UserDefaults.standard.string(forKey: UserDefaults.Keys.car.rawValue)
        
        switch carColor {
        case "Yellow":
            rootView.yellowCarView.setActive()
            rootView.greenCarView.setPassive()
        case "Green":
            rootView.yellowCarView.setPassive()
            rootView.greenCarView.setActive()
        default: break
        }
        
        let obstacleType = UserDefaults.standard.string(forKey: UserDefaults.Keys.obstacle.rawValue)
        
        switch obstacleType {
        case "Bush":
            rootView.bushView.setActive()
            rootView.coneView.setPassive()
        case "Cone":
            rootView.bushView.setPassive()
            rootView.coneView.setActive()
        default: break
        }
    
        let yellowCarGesture = UITapGestureRecognizer(target: self, action: #selector(didTapYellowCar))
        let greenCarGesture = UITapGestureRecognizer(target: self, action: #selector(didTapGreenCar))
        let bushGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBush))
        let coneGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCone))
        
        rootView.yellowCarView.isUserInteractionEnabled = true
        rootView.greenCarView.isUserInteractionEnabled = true
        rootView.bushView.isUserInteractionEnabled = true
        rootView.coneView.isUserInteractionEnabled = true

        rootView.yellowCarView.addGestureRecognizer(yellowCarGesture)
        rootView.greenCarView.addGestureRecognizer(greenCarGesture)
        rootView.bushView.addGestureRecognizer(bushGesture)
        rootView.coneView.addGestureRecognizer(coneGesture)
    }
    
    @objc func didTapYellowCar() {
        rootView.yellowCarView.setActive()
        rootView.greenCarView.setPassive()
        
        UserDefaults.standard.set("Yellow", forKey: UserDefaults.Keys.car.rawValue)
    }
    
    @objc func didTapGreenCar() {
        rootView.yellowCarView.setPassive()
        rootView.greenCarView.setActive()
        
        UserDefaults.standard.set("Green", forKey: UserDefaults.Keys.car.rawValue)
    }
    
    @objc func didTapBush() {
        rootView.bushView.setActive()
        rootView.coneView.setPassive()
        
        UserDefaults.standard.set("Bush", forKey: UserDefaults.Keys.obstacle.rawValue)
    }
    
    @objc func didTapCone() {
        rootView.bushView.setPassive()
        rootView.coneView.setActive()
        
        UserDefaults.standard.set("Cone", forKey: UserDefaults.Keys.obstacle.rawValue)
    }
    
    @IBAction func didTapResetRecords() {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }
    
    @IBAction func didTapSaveName() {
        UserDefaults.standard.set(rootView.textField.text, forKey: UserDefaults.Keys.racerName.rawValue)
        rootView.textField.text = ""
    }
    
}
