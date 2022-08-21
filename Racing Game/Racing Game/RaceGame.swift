import UIKit

class RaceGame: UIViewController {
    var road1: UIImageView = UIImageView()
    var road2: UIImageView = UIImageView()
    var bush: UIImageView = UIImageView()
    var car: UIImageView = UIImageView()
    
    var timer: Timer?
    var roadTimer: Timer?
    var timerToCompare: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        car.image = UIImage(named: "Car")
        car.frame = CGRect(x: UIScreen.main.bounds.width / 2 + 10, y: UIScreen.main.bounds.height - 300, width: 150, height: 150)
        view.addSubview(car)
        
        let rightArrowImage = UIImage(named: "RightArrow")
        let rightArrowButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 + 45, y: UIScreen.main.bounds.height - 140, width: 100, height: 100))
        rightArrowButton.setImage(rightArrowImage, for: .normal)
        rightArrowButton.addTarget(self, action: #selector(didTapToMoveRight), for: .touchUpInside)
        view.addSubview(rightArrowButton)
        
        let leftArrowImage = UIImage(named: "RightArrow")
        let leftArrowButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 145, y: UIScreen.main.bounds.height - 140, width: 100, height: 100))
        leftArrowButton.setImage(leftArrowImage, for: .normal)
        leftArrowButton.transform = leftArrowButton.transform.rotated(by: CGFloat(Double.pi))
        leftArrowButton.addTarget(self, action: #selector(didTapToMoveLeft), for: .touchUpInside)
        view.addSubview(leftArrowButton)
        
        moveBush()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveBush), userInfo: nil, repeats: true)
        roadTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(moveRoad), userInfo: nil, repeats: false)
        
    }
    
    @objc func moveBush() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let randomLine: Int = .random(in: 1...2)
        var randomPositionOfBush = 0
        
        switch randomLine {
        case 1: randomPositionOfBush = Int(screenWidth/2 - 160)
        case 2: randomPositionOfBush = Int(screenWidth/2 + 20)
        default: break
        }
        
        bush.image = UIImage(named: "Bush")
        bush.frame = CGRect(x: randomPositionOfBush, y: -128, width: 150, height: 150)
        self.view.addSubview(bush)
        
        timerToCompare = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: {
            timerToCompare in
            self.bush.frame.origin.y += 8
            
            if self.bush.frame.minY > screenHeight {
                timerToCompare.invalidate()
            }
            
            if self.bush.frame.intersects(self.car.frame) {
                timerToCompare.invalidate()
                self.view.willRemoveSubview(self.bush)
                self.timer?.invalidate()
                
                let alert = UIAlertController(title: "Game Over", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Menu", style: .cancel, handler: {
                    _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {
                    _ in
                    self.moveBush()
                    self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.moveBush), userInfo: nil, repeats: true)
                }))
                self.present(alert, animated: true)
            }
        })
    }

    @objc func moveRoad() {
        road1.image = UIImage(named: "Road")
        road1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        road1.layer.zPosition = -1
        self.view.addSubview(road1)
        
        road2.image = UIImage(named: "Road")
        road2.frame = CGRect(x: 0, y: -896, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        road2.layer.zPosition = -1
        self.view.addSubview(road2)
        
        roadTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            var currentCenterRoad2 = self.road2.center
            currentCenterRoad2.y += 2
            self.road2.center = currentCenterRoad2
            if self.road2.frame.origin.y == 896 {
                self.road2.frame.origin.y = -896
            }
            
            var currentCenterRoad1 = self.road1.center
            currentCenterRoad1.y += 2
            self.road1.center = currentCenterRoad1
            if self.road1.frame.origin.y == 896 {
                self.road1.frame.origin.y = -896
            }
        }
        
        self.view.willRemoveSubview(self.road1)
        self.view.willRemoveSubview(self.road2)
    }
    
    @objc func didTapToMoveRight() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
            if self.car.frame.maxX + 170 > screenWidth {
                self.car.frame = CGRect(x: self.car.frame.minX, y: self.car.frame.minY, width: 150, height: 150)
            } else {
                self.car.frame = CGRect(x: self.car.frame.minX + 170, y: self.car.frame.minY, width: 150, height: 150)
            }
        }
    }
    
    @objc func didTapToMoveLeft() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
            if self.car.frame.maxX - 170 < 170 {
                self.car.frame = CGRect(x: self.car.frame.minX, y: self.car.frame.minY, width: 150, height: 150)
            } else {
                self.car.frame = CGRect(x: self.car.frame.minX - 170, y: self.car.frame.minY, width: 150, height: 150)
            }
        }
    }
    
    @objc func didTapClose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
