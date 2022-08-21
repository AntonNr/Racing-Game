import UIKit

class MainMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

