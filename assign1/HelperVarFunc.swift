//
//  HelperFunc.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/12.
//

import Foundation

var currentDate : Date {
    return Date.now
}

enum Gender: String{
//    case Unknown = "Unknown"
    case Male = "Male"
    case Female = "Female"
}

// This function is AI generated
func dateFromString(_ dateString: String) throws-> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    if formatter.date(from: dateString) != nil {
        return formatter.date(from: dateString)
    }
    else{
        throw MyError.invalidInput("Wrong date format! Using yyyy-MM-dd")
    }
}

// This function is AI generated
func stringFromDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}
