import UIKit

class MainMenu: UIViewController {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var highscoresButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let attributed: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont(name: "RubikDirt-Regular", size: 40)]
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
        let viewController = str.instantiateViewController(withIdentifier: "RaceGame") as! RaceGame
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapHighscore(){
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = str.instantiateViewController(withIdentifier: "HighscoreTable") as! HighscoreTable
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapSettings(){
        let str: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = str.instantiateViewController(withIdentifier: "Settings") as! Settings
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(viewController, animated: true)
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
