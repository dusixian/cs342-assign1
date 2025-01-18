//
//  ContentView.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

import SwiftUI

struct PatientListView: View {
    @State private var searchText = "" // for search
    @State private var showPatientForm = false // for sheet
    
    // add some example here for better preview
    @State var patients: [Patient] = [
        try! Patient(
            firstName: "Rachel", lastName: "Green", height: 162, weight: 60, gender: Gender.Female, bloodType: BloodType.Bp, medications: [], dateOfBirth: "2002-07-02"),
        try! Patient(
            firstName: "Chandler", lastName: "Bing", height: 172, weight: 50, gender: Gender.Male, bloodType: BloodType.Ap, medications: [], dateOfBirth: "2001-06-03"),
        try! Patient(
            firstName: "Ross", lastName: "Geller", height: 180, weight: 78, gender: Gender.Unknown, bloodType: BloodType.On, medications: [], dateOfBirth: "1996-10-06"),
        try! Patient(
            firstName: "Monica", lastName: "Geller", height: 160, weight: 48, gender: Gender.Female, bloodType: BloodType.On, medications: [], dateOfBirth: "2000-09-06")
    ]
    
    var body: some View {
        NavigationStack {
            List{
                // add patient button
                Button(action: { showPatientForm.toggle() }) {
                    Label("Add Patient", systemImage: "person.fill.badge.plus")
                }
                .accessibilityIdentifier("addPatient")
                
                // show each patient
                ForEach(searchResults){
                    patient in
                    NavigationLink(value: patient) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(patient.lastName), \(patient.firstName) (\(patient.age))")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("ID: \(String(format: "%05d", patient.medicalRecordNumber))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Patients")
            .navigationDestination(for: Patient.self) { patient in
                PatientDetailView(patient: patient)
            }
            .searchable(text: $searchText, prompt: "Search patient by last name")
            .sheet(isPresented: $showPatientForm) {
                PatientFormView(showPatientForm: $showPatientForm){ newPatient in
                    patients.append(newPatient)
                }
            }
        }
    }
    
    // search result based on last name sorted by last name (then first name)
    var searchResults: [Patient] {
        if searchText.isEmpty {
            return patients.sorted(by: { ($0.lastName, $0.firstName) < ($1.lastName, $1.firstName) })
        } else {
            return patients.filter { $0.lastName.contains(searchText) }
        }
    }
    
//    func addPatient() -> PatientFormView {
//         return PatientFormView()
//    }
}

#Preview {
    PatientListView()
}
