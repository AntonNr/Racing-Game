import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var highscoresButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizedString()
        
        let attributed: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont(name: "RubikDirt-Regular", size: 40) as Any]
        let attrString = NSAttributedString(string: "Race Game", attributes: attributed)
        mainLabel.attributedText = attrString
        
        startButton.cornerRadius(radius: 20)
        startButton.drawShadow()
        
        highscoresButton.cornerRadius(radius: 20)
        highscoresButton.drawShadow()
        
        settingsButton.cornerRadius(radius: 20)
        settingsButton.drawShadow()
    }

    @IBAction func didTapStart(){
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = str.instantiateViewController(withIdentifier: "RaceGameViewController") as! RaceGameViewController
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapHighscore(){
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = str.instantiateViewController(withIdentifier: "HighscoreTableViewContoller") as! HighscoreTableViewContoller
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapSettings(){
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = str.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func localizedString() {
        startButton.titleLabel?.text = NSLocalizedString("main_menu_play_button", comment: "")
        highscoresButton.titleLabel?.text = NSLocalizedString("main_menu_highscores_button", comment: "")
        settingsButton.titleLabel?.text = NSLocalizedString("main_menu_settings_button", comment: "")
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
