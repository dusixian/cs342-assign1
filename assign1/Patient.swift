//
//  Patient.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

import Foundation

@Observable
class Patient: Identifiable, Hashable{
//    static var idCount: Int = 0
    let medicalRecordNumber: UUID = UUID()
    let firstName: String
    let lastName: String
    var height: Int
    let weight: Int
    var bloodType: BloodType?
    var gender: Gender?
    var medications: [Medication]
    var dateOfBirth: Date
    var age: Int {
        return getAge()
    }
    
    static func == (lhs: Patient, rhs: Patient) -> Bool {
        return lhs.medicalRecordNumber == rhs.medicalRecordNumber
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(medicalRecordNumber)
    }
    
    init(firstName: String, lastName: String, height: Int, weight: Int, gender: Gender? = nil,
         bloodType: BloodType? = nil, medications: [Medication], dateOfBirth: Date) throws{
        guard dateOfBirth <= Date() else {
            throw MyError.invalidInput("Date of birth cannot be in the future.")
        }
        self.firstName = firstName
        self.lastName = lastName
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
        self.medications = medications
        self.gender = gender
        self.dateOfBirth = dateOfBirth
    }
    
    // getAge from birth to now
    func getAge() -> Int{
        // This Calendar related usage is AI generated
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: currentDate)
        return age.year ?? 0
    }
    
    func basicInfo() -> String{
        // This Calendar related usage is AI generated
        let age = self.getAge()
        return "\(self.lastName), \(self.firstName)(\(age))"
    }
    
    func getMedications() -> [Medication]{
        let sortedMedication: [Medication] = self.medications.sorted{$0.date < $1.date} // sort
        return sortedMedication.filter{$0.isCompleted==false} // only include not completed medications
    }
    
    func addMedication(_ medication: Medication) throws -> Bool{
        let currMedication = self.getMedications()
        // first if the medication has completed, no need to check it
        if medication.isCompleted{
            self.medications.append(medication)
            return true
        }
        // not completed
        for med in currMedication{
            if medication.name == med.name{
                throw MyError.duplicatedMedication
            }
        }
        self.medications.append(medication)
        return true
    }
    
    // return a compatible blood type list
    func getCompatibleBloodType() throws -> [BloodType]{
        switch self.bloodType{
        case .ABp:
            return [.ABn, .ABp, .An, .Ap, .Bn, .Bp, .On, .Op]
        case .ABn:
            return [.On, .Bn, .An, .ABn]
        case .Ap:
            return [.On, .Op, .An, .Ap]
        case .An:
            return [.On, .An]
        case .Bp:
            return [.On, .Op, .Bn, .Bp]
        case .Bn:
            return [.On, .Bn]
        case .Op:
            return [.On, .Op]
        case .On:
            return [.On]
        default:
            throw MyError.missingBloodType
        }
    }
    
    // check if a specific blood type is compatible
    func checkCompatibleBloodType(_ receivedType: BloodType) throws -> Bool{
        let compatibleBloodTypes = try self.getCompatibleBloodType()
        return compatibleBloodTypes.contains(receivedType)
    }
    
}
