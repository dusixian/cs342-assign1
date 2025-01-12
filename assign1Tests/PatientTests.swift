//
//  PatientTests.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/12.
//

import Testing
import Foundation
@testable import assign1

func stringFromDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}

@MainActor
struct PatientTests{
    @Test func checkInit() async throws{
        let patient = Patient(
            firstName: "Alice",
            lastName: "A",
            height: 162,
            weight: 60,
            bloodType: BloodType.Bp,
            medications: [],
            dateOfBirth: "2002-07-02"
        )
        
        #expect(patient.firstName == "Alice")
        #expect(patient.lastName == "A")
        #expect(patient.height == 162)
        #expect(patient.weight == 60)
        #expect(patient.bloodType == .Bp)
        #expect(patient.medications.isEmpty)
        #expect(stringFromDate(patient.dateOfBirth) == "2002-07-02")
        
        // situation when missing bloodtype
        var patient_2 = Patient(
            firstName: "Alice",
            lastName: "A",
            height: 162,
            weight: 60,
            medications: [],
            dateOfBirth: "2002-07-02"
        )
        #expect(patient_2.bloodType == BloodType.Unknown)
        
        // assign bloodtype after
        patient_2.bloodType = BloodType.Ap
        #expect(patient_2.bloodType == BloodType.Ap)
    }
    
    @Test func checkRecordNumber() async throws{
        var recordLists: [Int] = []
        var patients: [Patient] = []
        for _ in 0..<100{
            let patient = Patient(
                firstName: "Alice",
                lastName: "A",
                height: 162,
                weight: 60,
                bloodType: .Bp,
                medications: [],
                dateOfBirth: "2002-07-02"
            )
            patients.append(patient)
            #expect(!recordLists.contains(patient.medicalRecordNumber))
            recordLists.append(patient.medicalRecordNumber)
        }
    }
    
    @Test func checkBasicInfo() async throws{
        let patient = Patient(
            firstName: "Alice",
            lastName: "A",
            height: 162,
            weight: 60,
            bloodType: .Bp,
            medications: [],
            dateOfBirth: "2002-07-02"
        )
        // TODO: correct for years later
        #expect(patient.basicInfo() == "A, Alice(22)")
    }
    
    @Test func checkGetAddMedications() async throws{
        // check get medications return in time order
        let medication_1 = try Medication(
            date: "2025-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1, // todo: also allow "once"
            duration: 90
        )
        
        let medication_2 = try Medication(
            date: "2025-01-01",
            name: "Aspirin",
            dose: 81,
            route: "by mouth",
            frequency: 1, // todo: also allow "once"
            duration: 90
        )
        
        var patient = Patient(
            firstName: "Alice",
            lastName: "A",
            height: 162,
            weight: 60,
            bloodType: .Bp,
            medications: [medication_1, medication_2],
            dateOfBirth: "2002-07-02"
        )
        
        #expect(patient.getMedications() == [medication_2, medication_1])
        
        // check get medications not return complete one
        let medication_3 = try Medication(
            date: "2024-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1, 
            duration: 90
        )
        
        patient.medications.append(medication_3)
        #expect(patient.getMedications() == [medication_2, medication_1])
        
        // check add medication which: 1. not complete 2. not duplicate
        let medication_4 = try Medication(
            date: "2025-01-11",
            name: "Losartan",
            dose: 12.5,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        #expect(patient.addMedication(medication_4))
        
        // check add medication which: 1.not complete 2. duplicate
        let medication_5 = try Medication(
            date: "2025-01-10",
            name: "Losartan",
            dose: 1,
            route: "by mouth",
            frequency: 1,
            duration: 20
        )
        #expect(!patient.addMedication(medication_5))
        
        // check add medication which: 1. complete 2. duplicate
        let medication_6 = try Medication(
            date: "2024-01-11",
            name: "Losartan",
            dose: 12.5,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        #expect(patient.addMedication(medication_6))
    }
}

