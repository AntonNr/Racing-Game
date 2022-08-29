import UIKit

class RaceGameViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    var road1: UIImageView = UIImageView()
    var road2: UIImageView = UIImageView()
    var obstacle: UIImageView = UIImageView()
    var car: UIImageView = UIImageView()
    var score: Int = 0
    var distance: Double = 0.0
    var roundedDistance: Double = 0.0
    
    var timer: Timer?
    var roadTimer: Timer?
    var timerToCompare: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let carColor = UserDefaults.standard.string(forKey: "kCar")
        
        switch carColor {
        case "Yellow":
            car.image = UIImage(named: "Yellow Car")
        case "Green":
            car.image = UIImage(named: "Green Car")
        default: break
        }
        
        car.frame = CGRect(x: UIScreen.main.bounds.width / 2 + 45, y: UIScreen.main.bounds.height - 300, width: 75, height: 150)
        view.addSubview(car)
        
        let rightArrowImage = UIImage(named: "RightArrow")
        let rightArrowButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 + 45, y: UIScreen.main.bounds.height - 140, width: 100, height: 100))
        rightArrowButton.setImage(rightArrowImage, for: .normal)
        rightArrowButton.addTarget(self, action: #selector(didTapToMoveRight), for: .touchUpInside)
        view.addSubview(rightArrowButton)
        
        let leftArrowImage = UIImage(named: "LeftArrow")
        let leftArrowButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 145, y: UIScreen.main.bounds.height - 140, width: 100, height: 100))
        leftArrowButton.setImage(leftArrowImage, for: .normal)
        leftArrowButton.addTarget(self, action: #selector(didTapToMoveLeft), for: .touchUpInside)
        view.addSubview(leftArrowButton)
        
        moveBush()
        timer = Timer.scheduledTimer(timeInterval: 11, target: self, selector: #selector(moveBush), userInfo: nil, repeats: true)
        roadTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(moveRoad), userInfo: nil, repeats: false)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
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
        
        let obstacleType = UserDefaults.standard.string(forKey: "kObstacle")
        
        switch obstacleType {
        case "Bush": obstacle.image = UIImage(named: "Bush")
        case "Cone": obstacle.image = UIImage(named: "Cone")
        default: break
        }
        
        obstacle.frame = CGRect(x: randomPositionOfBush, y: -128, width: 150, height: 150)
        obstacle.layer.zPosition = -1
        self.view.addSubview(obstacle)
        
        timerToCompare = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: {
            timerToCompare in
            self.obstacle.frame.origin.y += 3
            
            if self.obstacle.frame.minY > screenHeight {
                timerToCompare.invalidate()
                self.score += 1
                self.scoreLabel.text = "Score: \(self.score)"
            }
            
            if self.obstacle.frame.intersects(self.car.frame) {
                timerToCompare.invalidate()
                self.view.willRemoveSubview(self.obstacle)
                self.timer?.invalidate()
                self.roadTimer?.invalidate()
                self.saveRecord()
                //UserDefaults.standard.reset()
                
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
        
        road1.image = UIImage(named: "Road2")
        road1.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        road1.layer.zPosition = -2
        self.view.addSubview(road1)
        
        road2.image = UIImage(named: "Road2")
        road2.frame = CGRect(x: 0, y: -896, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        road2.layer.zPosition = -2
        self.view.addSubview(road2)
        
        roadTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            var currentCenterRoad2 = self.road2.center
            currentCenterRoad2.y += 3
            self.road2.center = currentCenterRoad2
            if self.road2.frame.origin.y >= 896 {
                self.road2.frame.origin.y = -896
            }
            
            var currentCenterRoad1 = self.road1.center
            currentCenterRoad1.y += 3
            self.road1.center = currentCenterRoad1
            if self.road1.frame.origin.y >= 896 {
                self.road1.frame.origin.y = -896
            }
            
            self.distance += 0.01
            self.roundedDistance = round(self.distance * 10) / 10.0
            self.distanceLabel.text = "Distance: \(self.roundedDistance)"
        }
        
    }
    
    @objc func didTapToMoveRight() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
            if self.car.frame.maxX + 100 > screenWidth {
                self.car.frame = CGRect(x: self.car.frame.minX, y: self.car.frame.minY, width: 75, height: 150)
            } else {
                self.car.frame = CGRect(x: self.car.frame.minX + 165, y: self.car.frame.minY, width: 75, height: 150)
            }
        }
    }
    
    @objc func didTapToMoveLeft() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
            if self.car.frame.maxX - 100 < 170 {
                self.car.frame = CGRect(x: self.car.frame.minX, y: self.car.frame.minY, width: 75, height: 150)
            } else {
                self.car.frame = CGRect(x: self.car.frame.minX - 165, y: self.car.frame.minY, width: 75, height: 150)
            }
        }
    }
    
    @objc func didTapClose() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func saveRecord() {
        var records: [Results] = []
        
        if let recordsData = UserDefaults.standard.data(forKey: UserDefaults.Keys.records.rawValue) {
            if let oldRecords: [Results] = try? JSONDecoder().decode(Array<Results>.self, from: recordsData) {
                records = oldRecords
            }
        }
        
        let currentRecord = Results(name: UserDefaults.standard.object(forKey: UserDefaults.Keys.racerName.rawValue) as? String ?? "DefaultName", date: Date(), distance: roundedDistance, score: score)
        
        records.append(currentRecord)
        let recordsData = try? JSONEncoder().encode(records)
        UserDefaults.standard.set(recordsData, forKey: UserDefaults.Keys.records.rawValue)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        print(dateFormatter.string(from: currentRecord.date))
    }
    
}


