import Foundation

extension UserDefaults {

    enum Keys: String, CaseIterable {

        case car = "kCar"
        case obstacle = "kObstacle"
        case racerName = "kName"
        case records = "kRecords"

    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }

}
