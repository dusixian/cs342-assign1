//
//  ContentView.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

import SwiftUI

struct PatientFormView: View {
    @Binding var showPatientForm: Bool // to close the sheet
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var birthday: Date = Date()
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bloodType: String = "Not Set"
    @State private var gender: String = "Not Set"
    
    // we can multi types of alert
    @State private var alertMessage: String = ""
    
    // this usage is from AI. Use a closure to return the newly added patient
    var onSave: (Patient) -> Void
    
    var body: some View {
        NavigationStack{
            // fields
            Form{
                HStack {
                    Text("First Name")
                    TextField("First Name", text: $firstName)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Last Name")
                    TextField("Last Name", text: $lastName)
                        .multilineTextAlignment(.trailing)
                }
                Picker("Gender", selection: $gender) {
                    Text("Not Set").tag("Not Set")
                    Text("Female").tag("Female")
                    Text("Male").tag("Male")
                }.accessibilityIdentifier("genderPicker")
                
                DatePicker("Date of Birth", selection: $birthday, displayedComponents: [.date])
                    .accessibilityIdentifier("datePicker")
                
                HStack {
                    Text("Height")
                    TextField("Height", text: $height)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    Text("cm")
                }
                HStack {
                    Text("Weight")
                    TextField("Weight", text: $weight)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    Text("kg")
                }
                Picker("Blood Type", selection: $bloodType) {
                    Text("Not Set").tag("Not Set")
                    Text("A+").tag("A+")
                    Text("A-").tag("A-")
                    Text("B+").tag("B+")
                    Text("B-").tag("B-")
                    Text("AB+").tag("AB+")
                    Text("AB-").tag("AB-")
                    Text("O+").tag("O+")
                    Text("O-").tag("O-")
                }
            }
            // show alert when there is a alert message.
            // close it after clicking "OK"
            .alert(isPresented: .constant(!alertMessage.isEmpty)) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        alertMessage = ""
                    }
                )
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("New Patient").font(.headline)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action:{
                        showPatientForm = false
                    }){
                        Text("Cancel")
                    }
                    .accessibilityIdentifier("cancelAddPatient")
                }
                ToolbarItem{
                    Button(action:save){
                        Text("Save")
                    }
                    .disabled(!checkValid()) // all required fields filled in
                    .accessibilityIdentifier("savePatient")
                }
            }
        }
    }
    
    func checkValid() -> Bool{
        if !firstName.isEmpty && !lastName.isEmpty
            && !height.isEmpty && !weight.isEmpty{
            return true}
        return false
    }
    
    func save() {
        
        // check valid
        
        guard let heightValue = Int(height) else {
            alertMessage = "Please enter a valid height."
            return
        }

        guard let weightValue = Int(weight) else {
            alertMessage = "Please enter a valid weight."
            return
        }
        
        guard birthday <= Date() else {
            alertMessage = "Date of Birth must be in the past."
            return
        }


        do {
            let newPatient = try Patient(
                firstName: firstName,
                lastName: lastName,
                height: heightValue,
                weight: weightValue,
                gender: Gender(rawValue: gender),
                bloodType: BloodType(rawValue: bloodType),
                medications: [],
                dateOfBirth: birthday
            )
            onSave(newPatient)
            showPatientForm = false
        } catch {
            alertMessage = "Failed to create the patient. Please check your input."
        }
    }
}

//#Preview {
//    PatientFormView()
//}
