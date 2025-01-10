//
//  Patient.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

import Foundation

var currentDate : Date {
    return Date.now
}

struct Patient{
    let medicalRecordNumber: Int
    let firstName: String
    let lastName: String
    var height: Double
    let weight: Double
    var bloodType: BloodType
    var medications: [Medication]
    var dateOfBirth: Date
    
    func basicInfo() -> String{
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: currentDate)
        return self.lastName + ", " + self.firstName + "(\(age))"
    }
    
    func getMedication() -> [Medication]{
        let sortedMedication: [Medication] = self.medications.sorted{$0.date < $1.date}
        return sortedMedication.filter{$0.isCompleted==false}
    }
    
    func addMedication(_medication: Medication) -> Bool{
        let currMedication = self.getMedication()
        for medication in currMedication{
            if medication.name == medication.name{
                return false
            }
        }
        return true
    }
    
}
