//
//  Medication.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//
import Foundation

func dateFromString(_ dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: dateString)
}

struct Medication{
    var date: Date
    var name: String
    var dose: Double
    var route: String
    var frequency: Int
    var duration: Int
    var isCompleted: Bool {
        let endDate = Calendar.current.date(byAdding: .day, value: duration, to: date)!
        if endDate > currentDate{
            return false
        }
        return true
    }
    
    init(date: String, name: String, dose: Double, route: String, frequency: Int, duration: Int) {
        self.date = dateFromString(date) ?? Date()
        self.name = name
        self.dose = dose
        self.route = route
        self.frequency = frequency
        self.duration = duration
    }
}
