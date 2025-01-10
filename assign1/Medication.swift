//
//  Medication.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//
import Foundation

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
}
