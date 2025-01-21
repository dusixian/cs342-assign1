# Sixian Du's Submission for Assignment 2 - CS342
## File Organization
- assign1/: Contains frontend (UI, which file name ends with "View") and backend (data types definitions and methods)
- assign1Tests/: Contains unit tests for data type logic.
- assign1UITests/: Contains tests for UI logic.

## UI Design
### Patient List View
* Alphabetically sorted list by last name
* Each patient entry shows Full name (Age) and Medical record number
* Tapping on a patient entry navigates to the patient detail view
* Tapping "Add Patient" button to the new patient form (open as a sheet)
* Search by last name

### New Patient Form
* Required fields: First name, Last name, Date of birth, Height, Weight
* Optional fields: Gender (new added!), Blood type
* Form validation Check: 
    * whether height can be converted to double type
    * whether weight can be converted to double type
    * whether the patient instance can be successfully created
    * else, show alert (including which field is invalid)
* Save button to save the new patient. Disabled when missing any required field
* Cancel button return to the patient list view

### Patient Detail View
* section 1: displays all patient details
* section 2: 
    * displays current medications (with all details)
    * Button to prescribe new medications (opens Prescribe Medication View as a sheet)

### Prescribe Medication View
* Required medication details: Name, Dose, Route, Frequency, Duration
* Form validation Check: 
    * whether dose can be converted to double type
    * whether frequency can be converted to int type
    * whether duration can be converted to int type
    * whether the medication instance can be successfully created
    * else, show alert (including which field is invalid)
* Save button to save the new medication. Disabled when missing any required field
* Check for duplicate medications before saving. If duplicate, show alert.
* Cancel button return to the patient details view

## UI Test
1. Tap add patient button to create a new patient. Fill in all required fields, save patient. Automatically return to the patient list. Check if the new-added patient entry exist.
2. Tap the new-added patient entry. Tap add medication button to create new medication. Fill in all required fields, save medication. Automatically return to the patient details. Check if the new-added medication entry exist.
3. Tap add medication button to create duplicate medication (name is same as previous). Check if duplicate medication alert shows.

## AI Integration
This assignment uses AI ([shared link](https://chatgpt.com/share/678b2759-d588-8006-9938-5aef806a3117)).


# Sixian Du's Submission for Assignment 1 - CS342

## File Organization
- assign1/: Contains data type definitions and methods.
- assign1Tests/: Contains unit tests for data type logic.
- assign1UITests/: Reserved for future assignments.

## Data Types
### BloodType
Defined as an enumeration to list all blood types. Includes an "unknown" type, which indicates that the blood type has not been defined yet (could happen when creating a patient instance).

### Medication
#### Fields
- Basic fields as specified in the requirements (`name`, `dose`, etc.).
- date: Uses the `Date` type from Foundation.
- isCompleted: A read-only property. Returns `false` if the end date (= prescribed date + duration) is later than the current date. Otherwise, returns `true`.

#### Methods
- init: Initializes the fields. Special features:
  - Enables string input for the `date` field (e.g., `"2025-01-12"`) and converts it to the `Date` type (see HelperVarFunc).
  - Allows string input for `frequency` (supports `"once"`, `"twice"`, and `"three times"`) and converts it into an integer. Throws an error for invalid input.
- frequency2Int: Converts frequency from a string to an integer (or retains it as an integer). Throws an error for unknown types or strings.

### Patient
#### Fields
- Basic fields as specified in the requirements (e.g., `medicalRecordNumber`, `firstName`, `lastName`, etc.).
- idCount: A static variable (initialized to 0) used to generate unique IDs for each patient.

#### Methods
- init: Initializes the fields. Special features:
  - Assigns the value of `idCount` as the `medicalRecordNumber` for the patient, then adds `idCount` by 1.
  - Enables string input for the `dateOfBirth` field (e.g., `"2002-01-01"`) and converts it to the `Date` type.
- getAge: Computes the patient's age (in years) from their birth date using `Calendar`.
- basicInfo: Returns a string in the format: `“Last name, First name (Age in years)”`.
- getMedications: Returns a list of medications the patient is currently taking (not completed), ordered by the date prescribed (from oldest to newest).
- addMedication: Adds a new medication. If the new medication is not completed and its name matches an existing medication, throws a `duplicatedMedication` error.
- getCompatibleBloodType: Determines which donor blood types the patient can receive. Throws a `missingBloodType` error if the patient's blood type has not been defined.
- checkCompatibleBloodType: Checks whether a specific donor blood type is compatible with the patient.

### HelperVarFunc
- currentDate: Returns the current date.
- dateFromString: Converts a string (e.g., `"2025-01-12"`) to a `Date` type. Throws an `invalidInput` error if the conversion fails.
- stringFromDate: Converts a `Date` type to a string (e.g., `"2025-01-12"`).

### Error
- invalidInput
- duplicatedMedication: used in Patient/addMedication
- missingBloodType: used in Patient/getCompatibleBloodType

## Unit Tests
- MedicationTests: Tests the `Medication` type and its methods.
- PatientTests: Tests the `Patient` type and its methods.

## AI Integration
This assignment uses AI ([shared link](https://chatgpt.com/share/67847a20-e3bc-8006-a71a-78200aba8baa)). Code that integrates with AI is commented in the repository.
