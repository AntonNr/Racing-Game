import Foundation
import UIKit

class SettingsView: UIView {
    
    @IBOutlet var settingsLabel: UILabel!
    @IBOutlet var racerNameLabel: UILabel!
    @IBOutlet var obstacleLabel: UILabel!
    @IBOutlet var carLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet var greenCarView: UIImageView!
    @IBOutlet var yellowCarView: UIImageView!
    @IBOutlet var bushView: UIImageView!
    @IBOutlet var coneView: UIImageView!
    
    func decorate() {
        
        resetButton.cornerRadius(radius: 10)
        resetButton.drawShadow()
        saveButton.cornerRadius(radius: 10)
        saveButton.drawShadow()
        
        backgroundColor = .systemYellow
        textField.backgroundColor = UIColor(red: 1, green: 0.70, blue: 0, alpha: 1)
        
        racerNameLabel.font = UIFont.italicSystemFont(ofSize: 25)
        carLabel.font = UIFont.italicSystemFont(ofSize: 25)
        obstacleLabel.font = UIFont.italicSystemFont(ofSize: 25)
        
        yellowCarView.image = UIImage(named: "Yellow Car")
        greenCarView.image = UIImage(named: "Green Car")
        bushView.image = UIImage(named: "Bush")
        coneView.image = UIImage(named: "Cone")
        
    }
    
    func localizedStrings() {
        saveButton.setTitle(NSLocalizedString("settings_save_button", comment: ""), for: .normal)
        resetButton.setTitle(NSLocalizedString("settings_reset_records_button", comment: ""), for: .normal)
        settingsLabel.text = NSLocalizedString("settings_label", comment: "")
        racerNameLabel.text = NSLocalizedString("settings_racer_name_label", comment: "")
        carLabel.text = NSLocalizedString("settings_car_label", comment: "")
        obstacleLabel.text = NSLocalizedString("settings_obstacle_type_label", comment: "")
    }
    
}

extension UIImageView {
    func setActive() {
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
        layer.cornerRadius = 10
    }
    
    func setPassive() {
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.cornerRadius = 10
    }
}
