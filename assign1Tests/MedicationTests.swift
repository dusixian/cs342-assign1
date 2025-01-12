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
        let medication = Medication(
            date: "2025-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1, // TODO: also allow "once"
            duration: 90
        )
        func stringFromDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        #expect(stringFromDate(medication.date) == "2025-01-11")
        #expect(medication.name == "Metoprolol")
        #expect(medication.dose == 25.0)
        #expect(medication.route == "by mouth")
        #expect(medication.frequency == 1)
        #expect(medication.duration == 90)
    }
    
    @Test func checkCompletedLogic() async throws{
        let medication = Medication(
            date: "2025-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1, 
            duration: 90
        )
        #expect(!medication.isCompleted)
        
        let completedMedication = Medication(
            date: "2024-01-11",
            name: "Metoprolol",
            dose: 25,
            route: "by mouth",
            frequency: 1,
            duration: 90
        )
        #expect(completedMedication.isCompleted)
    }
    
    // Todo: Invaild init
}
