//
//  Patient.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

import Foundation

class Patient{
    static var idCount: Int = 0
    let medicalRecordNumber: Int
    let firstName: String
    let lastName: String
    var height: Double
    let weight: Double
    var bloodType: BloodType
    var medications: [Medication]
    var dateOfBirth: Date
    
    init(firstName: String, lastName: String, height: Double, weight: Double,
         bloodType: BloodType = .Unknown, medications: [Medication], dateOfBirth: String) throws{
        self.medicalRecordNumber = Patient.idCount
        Patient.idCount += 1
        self.firstName = firstName
        self.lastName = lastName
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
        self.dateOfBirth = try dateFromString(dateOfBirth)!
    }
    
    func getAge() -> Int{
        // This Calendar related usage is AI generated
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: currentDate)
        return age.year ?? 0
    }
    
    func basicInfo() -> String{
        // This Calendar related usage is AI generated
        let age = self.getAge()
        return self.lastName + ", " + self.firstName + "(\(age))"
    }
    
    func getMedications() -> [Medication]{
        let sortedMedication: [Medication] = self.medications.sorted{$0.date < $1.date}
        return sortedMedication.filter{$0.isCompleted==false}
    }
    
    func addMedication(_ medication: Medication) throws -> Bool{
        let currMedication = self.getMedications()
        // first if the medication has completed, no need to check it
        if medication.isCompleted{
            self.medications.append(medication)
            return true
        }
        for med in currMedication{
            if medication.name == med.name{
                throw MyError.duplicatedMedication
            }
        }
        self.medications.append(medication)
        return true
    }
    
}
