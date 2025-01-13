//
//  Medication.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//
import Foundation

struct Medication: Equatable{
    var date: Date
    var name: String
    var dose: Double
    var route: String
    var frequency: Int = 0
    var duration: Int
    var isCompleted: Bool {
        // This Calendar related usage is AI generated
        // if startdate + duration = enddate > currentdate, return false
        let endDate = Calendar.current.date(byAdding: .day, value: duration, to: date)!
        if endDate > currentDate{
            return false
        }
        return true
    }
    
    init(date: String, name: String, dose: Double, route: String, frequency: Any, duration: Int) throws {
        self.date = try dateFromString(date) ?? Date()
        self.name = name
        self.dose = dose
        self.route = route
        self.duration = duration
        self.frequency = try frequency2Int(frequency)
    }
    
    // allow "once", "twice" and "three times" input for frequency, converted to int
    func frequency2Int(_ frequency: Any) throws -> Int {
        if let f = frequency as? Int{
            return f
        }
        else if let f = frequency as? String{
            switch f.lowercased() {
            case "once":
                return 1
            case "twice":
                return 2
            case "three times":
                return 3
            default:
                throw(MyError.invalidInput("Frequency only support string input for once, twice, and three times! Or you can input an integer value!"))
            }
        }
        else{
            throw(MyError.invalidInput("Invalid input for frequency. Try an integer value or string input for once, twice, and three times!"))
        }
    }
}
