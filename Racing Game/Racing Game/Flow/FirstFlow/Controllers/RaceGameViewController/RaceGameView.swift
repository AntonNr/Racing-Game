import Foundation
import UIKit

class RaceGameView: UIView {
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    var road1: UIImageView = UIImageView()
    var road2: UIImageView = UIImageView()
    var obstacle: UIImageView = UIImageView()
    var car: UIImageView = UIImageView()
    var rightArrowButton: UIButton = UIButton()
    var leftArrowButton: UIButton = UIButton()
    var startedPositionOfBush: Int = 0
    
    func addObjectsOnTheScreen() {
        addButtons()
        addCar()
        addRoad()
        addObstacle()
    }
    
    func addCar() {
        let carColor = UserDefaults.standard.string(forKey: "kCar")
        
        switch carColor {
        case "Yellow":
            car.image = UIImage(named: "Yellow Car")
        case "Green":
            car.image = UIImage(named: "Green Car")
        default:
            car.image = UIImage(named: "Yellow Car")
        }
        
        car.frame = CGRect(x: UIScreen.main.bounds.width / 2 + 45, y: UIScreen.main.bounds.height - 300, width: 75, height: 150)
        self.addSubview(car)
    }
    
    func addButtons() {
        let rightArrowImage = UIImage(named: "RightArrow")
        rightArrowButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 + 45, y: UIScreen.main.bounds.height - 140, width: 100, height: 100))
        rightArrowButton.setImage(rightArrowImage, for: .normal)
        
        self.addSubview(rightArrowButton)
        
        let leftArrowImage = UIImage(named: "LeftArrow")
        leftArrowButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 145, y: UIScreen.main.bounds.height - 140, width: 100, height: 100))
        leftArrowButton.setImage(leftArrowImage, for: .normal)
        
        self.addSubview(leftArrowButton)
    }
    
    func addRoad() {
        road1.image = UIImage(named: "Road2")
        road1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        road1.layer.zPosition = -2
        self.addSubview(road1)
        
        road2.image = UIImage(named: "Road2")
        road2.frame = CGRect(x: 0, y: (-1) * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        road2.layer.zPosition = -2
        self.addSubview(road2)
    }
    
    func addObstacle() {
        let obstacleType = UserDefaults.standard.string(forKey: "kObstacle")
        
        switch obstacleType {
        case "Bush": obstacle.image = UIImage(named: "Bush")
        case "Cone": obstacle.image = UIImage(named: "Cone")
        default:
            obstacle.image = UIImage(named: "Bush")
        }
        
        obstacle.frame = CGRect(x: startedPositionOfBush, y: -128, width: 150, height: 150)
        obstacle.layer.zPosition = -1
        self.addSubview(obstacle)
    }
    
}
