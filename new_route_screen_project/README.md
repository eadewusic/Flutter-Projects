# Data Passing App

This Flutter application demonstrates how to pass data between screens. It includes two screens: **First Screen** for data input and **Second Screen** for displaying the passed data.

## **Features**
- Collect user input (name and email) on the first screen.
- Validate the input fields to ensure:
  - Name is not empty.
  - Email is not empty and has a valid format.
- Pass the input data to a second screen.
- Display the received data on the second screen.
- Navigate back to the first screen from the second screen.

## **Screens Overview**

### 1. **First Screen**
- **Widget Type**: Stateful Widget
- **Layout**:
  - Contains two input fields for name and email.
  - Includes a "Submit" button to navigate to the second screen.
- **Features**:
  - Validates the inputs using a `Form` widget.
  - Uses `TextEditingController` to manage input values.
  - Navigates to the second screen, passing the entered data.

### 2. **Second Screen**
- **Widget Type**: Stateless Widget
- **Layout**:
  - Displays the name and email passed from the first screen.
  - Includes a "Go Back" button to return to the first screen.

## **Validation Rules**
1. **Name**: Cannot be empty.
2. **Email**: 
   - Cannot be empty.
   - Must be in a valid email format (e.g., `example@domain.com`).
