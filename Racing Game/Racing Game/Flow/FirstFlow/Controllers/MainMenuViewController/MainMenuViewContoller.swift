import UIKit

class MainMenuViewController: UIViewController {

    //MARK: Properties
    @IBOutlet var rootView: MainMenuView!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.localizedString()
        rootView.decorate()
        
    }

    //MARK: IBActions
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
    
}
