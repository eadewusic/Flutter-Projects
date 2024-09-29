import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red, // Using crimson color as primary theme
      ),
      home: TempApp(),
    );
  }
}

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  double input = 0.0; // Variable to hold the input temperature
  double output = 0.0; // Variable to hold the converted temperature
  bool fOrC = true; // Variable to track if the input is in Celsius or Fahrenheit
  List<String> conversionHistory = []; // List to store conversion history

  @override
  Widget build(BuildContext context) {
    // TextField for user input
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(str); // Parse the input string to double
        } catch (e) {
          input = 0.0; // Handle invalid input
        }
      },
      decoration: InputDecoration(
        labelText:
            "Input temperature value in ${fOrC == false ? "Fahrenheit" : "Celsius"}", // Dynamic label based on selected unit
      ),
      textAlign: TextAlign.center,
    );

    // AppBar for the application
    AppBar appBar = AppBar(
      title: const Text(
        "Climi's Temperature Conversion App", // Title of the app
        style: TextStyle(color: Colors.white), // Set title text color to white
      ),
      backgroundColor: Colors.red, // Crimson app bar background color
    );

    // Container for temperature unit switch
    Container tempSwitch = Container(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          const Text("F"), // Fahrenheit label
          Radio<bool>(
            groupValue: fOrC,
            value: false, // Radio button for Fahrenheit
            onChanged: (v) {
              setState(() {
                fOrC = v ?? false; // Update the unit selection
              });
            },
          ),
          const Text("C"), // Celsius label
          Radio<bool>(
            groupValue: fOrC,
            value: true, // Radio button for Celsius
            onChanged: (v) {
              setState(() {
                fOrC = v ?? true; // Update the unit selection
              });
            },
          ),
        ],
      ),
    );

    // Container for the conversion button
    Container calcBtn = Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Crimson button color
          foregroundColor: Colors.white, // Set button text color to white
        ),
        child: const Text("Convert"), // Button text
        onPressed: () {
          setState(() {
            // Perform the temperature conversion
            if (fOrC == false) {
              output = (input - 32) * (5 / 9); // Convert Fahrenheit to Celsius
              conversionHistory.add(
                  "${input.toStringAsFixed(2)} F = ${output.toStringAsFixed(2)} C"); // Log conversion history
            } else {
              output = (input * 9 / 5) + 32; // Convert Celsius to Fahrenheit
              conversionHistory.add(
                  "${input.toStringAsFixed(2)} C = ${output.toStringAsFixed(2)} F"); // Log conversion history
            }
          });

          // AlertDialog to show the conversion result
          AlertDialog dialog = AlertDialog(
            content: fOrC == false
                ? Text(
                    "${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C") // Display conversion result for Fahrenheit
                : Text(
                    "${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F"), // Display conversion result for Celsius
          );

          // Show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialog;
            },
          );
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            inputField, // Input field for temperature
            tempSwitch, // Temperature unit switch
            calcBtn, // Conversion button
            const SizedBox(height: 20), // Space between the button and the list
            const SizedBox(height: 20), // Additional space before the title
            const Text(
              'Conversion History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: conversionHistory.length, // Number of items in history
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(conversionHistory[index]), // Display each conversion history item
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
