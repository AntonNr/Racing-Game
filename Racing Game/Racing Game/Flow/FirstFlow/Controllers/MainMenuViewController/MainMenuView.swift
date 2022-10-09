import Foundation
import UIKit

class MainMenuView: UIView {
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var highscoresButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    var bgRoad: UIImageView = UIImageView()
    var bgView: UIView = UIView()
    
    func decorate(){
        let attributed: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont(name: "RubikDirt-Regular", size: 40) as Any]
        let attrString = NSAttributedString(string: "Race Game", attributes: attributed)
        mainLabel.attributedText = attrString
        
        bgRoad.frame = self.bounds
        bgRoad.image = UIImage(named: "Road")
        bgRoad.contentMode = .scaleAspectFill
        
        bgView.backgroundColor = .black
        bgView.frame = self.bounds
        bgView.alpha = 0.3
        
        insertSubview(bgRoad, at: 0)
        insertSubview(bgView, at: 1)
    
        startButton.cornerRadius(radius: 15)
        startButton.drawShadow()
        startButton.layer.zPosition = 3
    
        highscoresButton.cornerRadius(radius: 15)
        highscoresButton.drawShadow()
    
        settingsButton.cornerRadius(radius: 15)
        settingsButton.drawShadow()
    }
    
    func localizedString() {
        startButton.setTitle(NSLocalizedString("main_menu_play_button", comment: ""), for: .normal)
        highscoresButton.setTitle(NSLocalizedString("main_menu_highscores_button", comment: ""), for: .normal)
        settingsButton.setTitle(NSLocalizedString("main_menu_settings_button", comment: ""), for: .normal)
    }
}

extension UIButton {
    func cornerRadius(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    
    func drawShadow() {
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 20
    }
}
