# Temperature Conversion App

## Overview

This **Temperature Conversion App** allows users to convert temperatures between Fahrenheit and Celsius. Users can select the conversion type, enter a temperature value, and view the converted temperature rounded to two decimal places. Additionally, a history of past conversions is displayed within the app.

## Features

- Convert between **Fahrenheit** and **Celsius**.
- User-friendly interface with a simple input form for temperature conversion.
- **History log** displaying past conversions.
- Consistent design in both **portrait** and **landscape** orientations.
- Accurate conversions displayed to **two decimal places**.
- Input validation ensures that only valid numbers are processed.

## Conversion Formulas

The app uses the following formulas for conversion:

- **Celsius to Fahrenheit**:  
  \[
  °F = (°C \times \frac{9}{5}) + 32
  \]
  
- **Fahrenheit to Celsius**:  
  \[
  °C = (°F - 32) \times \frac{5}{9}
  \]

## How It Works

1. **Conversion Selection**: The user selects the conversion type (Fahrenheit-to-Celsius or Celsius-to-Fahrenheit).
2. **User Input**: The user enters the temperature value in the provided input field.
3. **Conversion**: The user clicks the "Convert" button to display the converted temperature. The result is displayed with two decimal precision.
4. **History Log**: Each conversion is saved to the history log for reference. For example:
   - F to C: 55.0 => 12.8
   - C to F: 3.5 => 38.3

## Widgets Used

- **Radio Buttons / Dropdown**: To select between Fahrenheit-to-Celsius and Celsius-to-Fahrenheit conversions.
- **TextField**: For user input of the initial temperature.
- **Button**: To trigger the conversion.
- **Text Widget**: To display the result of the conversion.
- **ListView/ScrollView**: To display the history of conversions.
- **AlertDialog**: To display error messages in case of invalid input.

## Installation & Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/eadewusic/Flutter-Projects.git
   ```
2. Navigate to the project directory:
   ```bash
   cd temp_conversion
   ```
3. Run the project on an emulator or physical device:

   - For **Flutter**:
     ```bash
     flutter run
     ```

## Demo

You can find a demo of this app in action at the following link:
[Demo Video Link](https://)

## Code Breakdown

- The conversion logic is implemented in two functions for converting between Fahrenheit and Celsius.
- The app uses a **stateful widget** to manage the UI and the history log.
- The history list is dynamically updated and displayed using a ListView/ScrollView widget.
  
## Challenges and Solutions

1. **Portrait and Landscape Support**:
   - The UI was designed to scale properly in both orientations without losing any functionality or readability.

2. **Input Validation**:
   - An alert is shown if the user inputs invalid data (such as empty fields or non-numeric input).

## Conclusion

This Temperature Conversion App demonstrates basic mobile app development principles, including user input handling, conversions using mathematical formulas, and state management using widgets. It showcases a simple and user-friendly interface that works across multiple device orientations.
