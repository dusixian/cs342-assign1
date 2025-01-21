//
//  ContentView.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

import SwiftUI

struct MedicationSheetView: View {
    @Binding var isPresented: Bool // to close the sheet
//    @State private var showAlert: Bool = false
    
    @State var patient: Patient
    @State private var name: String = ""
    @State private var dose: String = ""
    @State private var unit: String = "mg"
    @State private var route: String = "by mouth"
    @State private var frequency: String = ""
    @State private var duration: String = ""
    
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    
//    var onSaveMedication: (Medication) -> Void
    
    var body: some View {
        NavigationStack {
            // fields
            Form{
                HStack {
                    Text("Name")
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.trailing)
                }
//                HStack {
//                    Text("Dose (mg)")
//                    TextField("Dose", text: $dose)
//                        .keyboardType(.decimalPad)
//                        .multilineTextAlignment(.trailing)
//                }
                HStack {
                    Text("Dose")
                        .frame(maxWidth: .infinity, alignment: .leading) // 左对齐
                    
                    TextField("Value", text: $dose)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    
                    Picker("", selection: $unit) {
                        Text("mg").tag("mg")
                        Text("g").tag("g")
                        Text("ml").tag("ml")
                    }.accessibilityIdentifier("doseUnitPicker")
                }
//                HStack {
//                    Text("Route")
//                    TextField("Route (e.g., by mouth)", text: $route)
//                        .autocapitalization(.none)
//                        .multilineTextAlignment(.trailing)
//                }
                Picker("Route", selection: $route) {
                    Text("by mouth").tag("by mouth")
                    Text("injection").tag("injection")
                    Text("topical").tag("topical")
                    Text("other").tag("other")
                }
                    .accessibilityIdentifier("routePicker")
                
                HStack {
                    Text("Frequency (per day)")
                    TextField("Frequency", text: $frequency)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Duration (days)")
                    TextField("Duration", text: $duration)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
            }
            // alert
            .alert(isPresented: .constant(!alertMessage.isEmpty)) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        alertMessage = ""
                    }
                )
            }
            .toolbar{
                // close sheet
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action:{
                        isPresented = false
                    }){
                        Text("Cancel")
                    }
                    .accessibilityIdentifier("cancelAddMedication")
                }
                // save medication
                ToolbarItem{
                    Button(action:saveMedication){
                        Text("Save")
                    }
                    .disabled(!checkValid())
                    .accessibilityIdentifier("saveMedication")
                }
                // title
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Prescribe").font(.headline)
                        Text("for \(patient.firstName) \(patient.lastName)").font(.subheadline)
                    }
                }
            }
        }
    }
    
    // only all fields are filled
    func checkValid() -> Bool{
        if !name.isEmpty && !dose.isEmpty && !route.isEmpty && !frequency.isEmpty && !duration.isEmpty{
            return true
        }
        return false
    }
    
    
    func saveMedication(){
        // check valid
        
        guard let doseValue = Int(dose) else {
            alertTitle = "Invalid Input"
            alertMessage = "Please enter a valid dose."
            return
        }
        
        guard let frequencyValue = Int(frequency) else {
            alertTitle = "Invalid Input"
            alertMessage = "Please enter a valid frequency."
            return
        }
        
        guard let durationValue = Int(duration) else {
            alertTitle = "Invalid Input"
            alertMessage = "Please enter a valid duration."
            return
        }
        
        do {
            let newMedication = try Medication(
                date: Date(),
                name: name,
                dose: Dosage(value:doseValue, unit:Dosage.Unit(rawValue: unit) ?? Dosage.Unit.mg),
                route: Route(rawValue: route) ?? Route.other,
                frequency: frequencyValue,
                duration: durationValue
            )
            
            do{
                try patient.addMedication(newMedication)
                isPresented = false
            } catch MyError.duplicatedMedication{
                alertTitle = "Duplicate Medication"
                alertMessage = "\(patient.firstName) \(patient.lastName) already has a medication with the same name."
            }catch {
                alertMessage = "An unexpected error occurred: \(error)"
            }
            
        } catch{
            alertTitle = "Invalid Input"
            alertMessage = "Failed to prescribe medication. Please check your input."
            return
        }
    }
}

//#Preview {
//    MedicationSheetView()
//}
