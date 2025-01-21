//
//  ContentView.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

import SwiftUI
import Observation

struct PatientDetailView: View {
    var patient: Patient // which patient (from previous view)
    @State private var isPresented = false // show add medication sheet

    var body: some View {
//        NavigationStack {
            List{
                // patient detail
                Section(header: Text("Basic Information")){
                    VStack(alignment: .leading){
                        Text("Gender")
                            .font(.subheadline)
                        Text(patient.gender?.rawValue ?? "Not Set")
                            .foregroundColor(.blue)
                    }
                    VStack(alignment: .leading) {
                        Text("Date of Birth (Age)")
                            .font(.subheadline)
                        Text(stringFromDate(patient.dateOfBirth) + " (\(patient.age))")
                            .foregroundColor(.blue)
                    }
                    VStack(alignment: .leading){
                        Text("Height")
                            .font(.subheadline)
                        Text("\(Int(patient.height)) cm")
                            .foregroundColor(.blue)
                    }
                    VStack(alignment: .leading){
                        Text("Weight")
                            .font(.subheadline)
                        Text("\(Int(patient.weight)) kg")
                            .foregroundColor(.blue)
                    }
                    VStack(alignment: .leading){
                        Text("Blood Type")
                            .font(.subheadline)
                        Text(patient.bloodType?.rawValue ?? "Not Set")
                            .foregroundColor(.blue)
                    }
                }
                // current medication
                Section(header: Text("Medications")){
                    // add medication
                    Button(action: { isPresented.toggle() }) {
                        Label("Prescribe New Medication", systemImage: "stethoscope")
                    }
                    .accessibilityIdentifier("addMedication")
                    
                    ForEach(shownMedications){
                        medication in
                        VStack(alignment: .leading) {
                            Text("\(medication.name)")
                                .font(.headline)
                                .foregroundColor(.blue)
                            Text("Taking \(medication.dose.value) \(medication.dose.unit) \(medication.route)")
                            Text("\(medication.frequency) time(s) per day for \(medication.duration) days")
//                            Text("Dose: \(medication.dose) mg")
//                            Text("Route: \(medication.route)")
//                            Text("Frequency: \(medication.frequency) per day")
//                            Text("Duration: \(medication.duration) days")
                            Text("from \(stringFromDate(medication.date))")
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("\(patient.firstName) \(patient.lastName)")
            .sheet(isPresented: $isPresented) {
                MedicationSheetView(isPresented: $isPresented, patient: patient)
//                { newMedication in
//                    try! patient.addMedication(newMedication)
//                }
            }
        }
    
    // only show not completed medications
    var shownMedications: [Medication] {
        return patient.getMedications()
    }
    
    
}

//#Preview {
//    let medication1 = try! Medication(
//        date: "2025-01-11",
//        name: "Metoprolol",
//        dose: 25,
//        route: "by mouth",
//        frequency: 1,
//        duration: 90
//    )
//    let medication2 = try! Medication(
//        date: "2025-01-01",
//        name: "Aspirin",
//        dose: 81,
//        route: "by mouth",
//        frequency: 1,
//        duration: 90
//    )
//
//    let newPatient = try! Patient(
//        firstName: "Rachel",
//        lastName: "Green",
//        height: 162,
//        weight: 60,
//        bloodType: .Bp,
//        medications: [medication1, medication2],
//        dateOfBirth: "2002-07-02"
//    )
//    PatientDetailView(patient: newPatient)
//}
