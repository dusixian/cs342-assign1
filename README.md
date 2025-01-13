# Sixian Du's Submission for Assignment 1 - CS342

## File Organization
- assign1/: Contains data type definitions and methods.
- assign1Tests/: Contains unit tests for data type logic.
- assign1UITests/: Reserved for future assignments.

## Data Types
### BloodType
Defined as an enumeration to list all blood types. Includes an "unknown" type, which indicates that the blood type has not been defined yet (e.g., when creating a patient instance).

### Medication
#### Fields
- Basic fields as specified in the requirements (`name`, `dose`, etc.).
- date: Uses the `Date` type from Foundation.
- isCompleted: A read-only property. Returns `false` if the end date (calculated as the prescribed date + duration) is later than the current date. Otherwise, returns `true`.

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
  - Assigns the value of `idCount` as the `medicalRecordNumber` for the patient, then increments `idCount` by 1.
  - Enables string input for the `dateOfBirth` field (e.g., `"2002-01-01"`) and converts it to the `Date` type.
- getAge: Computes the patient's age (in years) from their birth date using `Calendar`.
- basicInfo: Returns a string in the format: `“Last name, First name (Age in years)”`.
- getMedications: Returns a list of medications the patient is currently taking (i.e., not completed), ordered by the date prescribed.
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
- Two files:
  - MedicationTests: Tests the `Medication` type and its methods.
  - PatientTests: Tests the `Patient` type and its methods.

## AI Integration
This assignment uses AI ([shared link](https://chatgpt.com/share/67847a20-e3bc-8006-a71a-78200aba8baa)). Code that integrates with AI is commented in the repository.
