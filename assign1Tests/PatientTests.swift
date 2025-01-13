//
//  PatientTests.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/12.
//

import Testing
import Foundation
@testable import assign1

@MainActor
struct PatientTests{
    @Test func checkInit() async throws{
        let patient = try Patient(
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
        let patient_2 = try Patient(
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
        // create 100 instances for patient, check whether the medicalRecordNumbers duplicate
        for _ in 0..<100{
            let patient = try Patient(
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
        var age_22 = Calendar.current.date(byAdding: .year, value: -22, to: currentDate)!
        age_22 = Calendar.current.date(byAdding: .day, value: -1, to: age_22)!

        let patient = try Patient(
            firstName: "Alice",
            lastName: "A",
            height: 162,
            weight: 60,
            bloodType: .Bp,
            medications: [],
            dateOfBirth: stringFromDate(age_22)
        )
        
        #expect(patient.basicInfo() == "A, Alice(22)")
    }
    
    @Test func checkGetAddMedications() async throws{
        // check get medications return in time order
        let medication_1 = try Medication(
            date: "2025-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        
        let medication_2 = try Medication(
            date: "2025-01-01",
            name: "Aspirin",
            dose: 81,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        
        let patient = try Patient(
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
        #expect(try patient.addMedication(medication_4))
        
        // check add medication which: 1.not complete 2. duplicated
        let medication_5 = try Medication(
            date: "2025-01-10",
            name: "Losartan",
            dose: 1,
            route: "by mouth",
            frequency: 1,
            duration: 20
        )
        #expect(throws: MyError.duplicatedMedication){
            try patient.addMedication(medication_5)
        }
        
        // check add medication which: 1. complete 2. duplicated
        let medication_6 = try Medication(
            date: "2024-01-11",
            name: "Losartan",
            dose: 12.5,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        #expect(try patient.addMedication(medication_6))
    }
    
    @Test func checkReceiveBlood() async throws{
        let patient = try Patient(
            firstName: "Alice",
            lastName: "A",
            height: 162,
            weight: 60,
            medications: [],
            dateOfBirth: "2002-07-02"
        )
        #expect(throws: MyError.missingBloodType){
            try patient.getCompatibleBloodType()
        }
        #expect(throws: MyError.missingBloodType){
            try patient.checkCompatibleBloodType(BloodType.On)
        }
        
        patient.bloodType = BloodType.ABn
        #expect(try patient.getCompatibleBloodType() == [.On, .Bn, .An, .ABn])
        #expect(try !patient.checkCompatibleBloodType(BloodType.Op))
        #expect(try patient.checkCompatibleBloodType(BloodType.An))
    }
}

