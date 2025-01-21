//
//  assign1UITests.swift
//  assign1UITests
//
//  Created by 杜思娴 on 2025/1/10.
//

import XCTest
@testable import assign1

final class assign1UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Test add new patient
        let app = XCUIApplication()
        app.launch()
        let addPatientButton = app.buttons["addPatient"]
        XCTAssertTrue(addPatientButton.exists)
        addPatientButton.tap()
        let firstNameField = app.textFields["First Name"]
        XCTAssertTrue(firstNameField.exists)
        firstNameField.tap()
        firstNameField.typeText("Phoebe")

        let lastNameField = app.textFields["Last Name"]
        XCTAssertTrue(lastNameField.exists)
        lastNameField.tap()
        lastNameField.typeText("Buffay")

        let heightField = app.textFields["Height"]
        XCTAssertTrue(heightField.exists)
        heightField.tap()
        heightField.typeText("172")

        let weightField = app.textFields["Weight"]
        XCTAssertTrue(weightField.exists)
        weightField.tap()
        weightField.typeText("60")

        let genderPicker = app.buttons["genderPicker"]
        XCTAssertTrue(genderPicker.exists)
        genderPicker.tap()
        app.buttons["Female"].tap()
        
        let saveButton = app.buttons["savePatient"]
        XCTAssertTrue(saveButton.exists)
        saveButton.tap()
        
        let newPatient = app.staticTexts["Buffay, Phoebe (0)"]
        XCTAssertTrue(newPatient.exists)
        
        // Into patient Details
        // Test add new medication to this patient
        newPatient.tap()
        let addMedicationButton = app.buttons["addMedication"]
        XCTAssertTrue(addMedicationButton.exists)
        addMedicationButton.tap()
        
        let medicationNameField = app.textFields["Name"]
        XCTAssertTrue(medicationNameField.exists)
        medicationNameField.tap()
        medicationNameField.typeText("Aspirin")
        
        let medicationDoseField = app.textFields["Value"]
        XCTAssertTrue(medicationDoseField.exists)
        medicationDoseField.tap()
        medicationDoseField.typeText("10")
        
//        let medicationRouteField = app.textFields["Route (e.g., by mouth)"]
//        XCTAssertTrue(medicationRouteField.exists)
//        medicationRouteField.tap()
//        medicationRouteField.typeText("by mouth")
        
        let medicationRoutePicker = app.buttons["routePicker"]
        XCTAssertTrue(medicationRoutePicker.exists)
        medicationRoutePicker.tap()
        app.buttons["by mouth"].tap()
        
        let medicationFrequencyField = app.textFields["Frequency"]
        XCTAssertTrue(medicationFrequencyField.exists)
        medicationFrequencyField.tap()
        medicationFrequencyField.typeText("1")
        
        let medicationDurationField = app.textFields["Duration"]
        XCTAssertTrue(medicationDurationField.exists)
        medicationDurationField.tap()
        medicationDurationField.typeText("90")
        
        let saveMedButton = app.buttons["saveMedication"]
        XCTAssertTrue(saveMedButton.exists)
        saveMedButton.tap()
        
        let newMed = app.staticTexts["Aspirin"]
        XCTAssertTrue(newMed.exists)
        
        // Test add duplicated medication to this patient
        addMedicationButton.tap()
        medicationNameField.tap()
        medicationNameField.typeText("Aspirin")
        medicationDoseField.tap()
        medicationDoseField.typeText("1")
        medicationRoutePicker.tap()
        app.buttons["by mouth"].tap()
        medicationFrequencyField.tap()
        medicationFrequencyField.typeText("1")
        medicationDurationField.tap()
        medicationDurationField.typeText("30")
        saveMedButton.tap()
        let alert = app.alerts["Duplicate Medication"]
        XCTAssertTrue(alert.exists)
    }

//    @MainActor
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
