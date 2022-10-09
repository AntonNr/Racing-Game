import UIKit

class RaceGameViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var rootView: RaceGameView!
    
    var raceGameModel = RaceGameModel()
    var score: Int = 0
    var distance: Double = 0.0
    var roundedDistance: Double = 0.0
    var avatarIcon: UIImageView = UIImageView()
    var timer: Timer?
    var roadTimer: Timer?
    var timerToCompare: Timer?
    var timerToCarJump: Timer?
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.becomeFirstResponder()
        
        rootView.addObjectsOnTheScreen()
        rootView.rightArrowButton.addTarget(self, action: #selector(didTapToMoveRight), for: .touchUpInside)
        rootView.leftArrowButton.addTarget(self, action: #selector(didTapToMoveLeft), for: .touchUpInside)
        
        moveBush()
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(moveBush), userInfo: nil, repeats: true)
        roadTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(moveRoad), userInfo: nil, repeats: false)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //MARK: Moving functions
    @objc func moveRoad() {
        
        roadTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] _ in
            
            guard let self = self else { return }
            
            var currentCenterRoad2 = self.rootView.road2.center
            currentCenterRoad2.y += 4
            self.rootView.road2.center = currentCenterRoad2
            if self.rootView.road2.frame.origin.y >= UIScreen.main.bounds.height {
                self.rootView.road2.frame.origin.y = (-1) * UIScreen.main.bounds.height
            }
            
            var currentCenterRoad1 = self.rootView.road1.center
            currentCenterRoad1.y += 4
            self.rootView.road1.center = currentCenterRoad1
            if self.rootView.road1.frame.origin.y >= UIScreen.main.bounds.height {
                self.rootView.road1.frame.origin.y = (-1) * UIScreen.main.bounds.height
            }
            
            self.distance += 0.01
            self.roundedDistance = round(self.distance * 10) / 10.0
            self.rootView.distanceLabel.text = NSLocalizedString("race_distance_label", comment: "") + "\(self.roundedDistance)"
        }
        
    }
    
    @objc func moveBush() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let randomLine: Int = .random(in: 1...2)
        var randomPositionOfBush = 0
        
        switch randomLine {
        case 1: randomPositionOfBush = Int(screenWidth/2 - 160)
        case 2: randomPositionOfBush = Int(screenWidth/2 + 10)
        default: break
        }
        
        rootView.startedPositionOfBush = randomPositionOfBush
        rootView.addObstacle()
        
        timerToCompare = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { [weak self] timerToCompare in
            
            guard let self = self else { return }
            
            self.rootView.obstacle.frame.origin.y += 4
            
            self.rootView.scoreLabel.text = NSLocalizedString("race_score_label", comment: "") + "\(self.score)"
            
            if self.rootView.obstacle.frame.minY > screenHeight {
                timerToCompare.invalidate()
                self.score += 1
            }
            
            if self.rootView.obstacle.frame.intersects(self.rootView.car.frame) {
                timerToCompare.invalidate()
                self.view.willRemoveSubview(self.rootView.obstacle)
                self.timer?.invalidate()
                self.roadTimer?.invalidate()
                self.raceGameModel.saveRecordRealm(distance: self.roundedDistance, score: self.score)
                
                let alert = UIAlertController(title: NSLocalizedString("race_alert_intersects_title", comment: ""), message: "", preferredStyle: .alert)
                alert.message = NSLocalizedString("race_distance_label", comment: "") + String(self.roundedDistance) + "\n" + NSLocalizedString("race_score_label", comment: "") + String(self.score)
                alert.addAction(UIAlertAction(title: NSLocalizedString("race_alert_intersects_button1", comment: ""), style: .cancel, handler: {
                    _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("race_alert_intersects_button2", comment: ""), style: .default, handler: {
                    _ in
                    self.moveBush()
                    self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.moveBush), userInfo: nil, repeats: true)
                }))
                self.present(alert, animated: true)
            }
        })
    }
    
    @objc func didTapToMoveRight() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
            if self.rootView.car.frame.maxX + 100 > screenWidth {
                self.rootView.car.frame = CGRect(x: self.rootView.car.frame.minX, y: self.rootView.car.frame.minY, width: 75, height: 150)
            } else {
                self.rootView.car.frame = CGRect(x: self.rootView.car.frame.minX + 165, y: self.rootView.car.frame.minY, width: 75, height: 150)
            }
        }
    }
    
    @objc func didTapToMoveLeft() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
            if self.rootView.car.frame.maxX - 100 < 170 {
                self.rootView.car.frame = CGRect(x: self.rootView.car.frame.minX, y: self.rootView.car.frame.minY, width: 75, height: 150)
            } else {
                self.rootView.car.frame = CGRect(x: self.rootView.car.frame.minX - 165, y: self.rootView.car.frame.minY, width: 75, height: 150)
            }
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
            let carOriginYPozition = rootView.car.frame.origin.y
            rootView.car.frame.origin.y += 50
            
            timerToCarJump = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: false, block: { _ in
                if self.rootView.car.frame.origin.y != carOriginYPozition {
                    self.rootView.car.frame.origin.y -= 4
                }
            })
        }
    }
    
    func canBecomeFirstResponder() -> Bool {
        return true
    }
    
}


