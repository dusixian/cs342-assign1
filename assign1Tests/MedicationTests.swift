//
//  assign1Tests.swift
//  assign1Tests
//
//  Created by 杜思娴 on 2025/1/10.
//

import Testing
import Foundation
@testable import assign1

@MainActor
struct MedicationTests{
    @Test func checkInit() async throws{
        let medication = try Medication(
            date: "2025-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        #expect(stringFromDate(medication.date) == "2025-01-11")
        #expect(medication.name == "Metoprolol")
        #expect(medication.dose == 25.0)
        #expect(medication.route == "by mouth")
        #expect(medication.frequency == 1)
        #expect(medication.duration == 90)
        
        // check invalid datestr format
        #expect(throws: MyError.invalidInput("Wrong date format! Using yyyy-MM-dd")){
            try Medication(
                date: "20250111",
                name: "Metoprolol",
                dose: 25,
                route: "by mouth",
                frequency: 1,
                duration: 90
            )
        }
    }
    
    @Test func checkFrequencyInit() async throws{
        // check correct str input for frequency
        let medication = try Medication(
            date: "2025-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: "once",
            duration: 90
        )
        #expect(medication.frequency==1)
        
        // check invalid str input for frequency
        #expect(throws: MyError.invalidInput("Frequency only support string input for once, twice, and three times! Or you can input an integer value!")){
            try Medication(
                date: "2025-01-11",
                name: "Metoprolol",
                dose: 25,
                route: "by mouth",
                frequency: "four times",
                duration: 90
            )
        }
        
        // check invalid input type for frequency
        #expect(throws: MyError.invalidInput("Invalid input for frequency. Try an integer value or string input for once, twice, and three times!")){
            try Medication(
                date: "2025-01-11",
                name: "Metoprolol",
                dose: 25,
                route: "by mouth",
                frequency: 2.5,
                duration: 90
            )
        }
    }
    
    @Test func checkCompletedLogic() async throws{
        let medication = try Medication(
            date: "2025-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1, 
            duration: 90
        )
        #expect(!medication.isCompleted)
        
        let completedMedication = try Medication(
            date: "2024-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        #expect(completedMedication.isCompleted)
    }
}
