import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // Using MaterialColor
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
  double input = 0.0; // Initialized with 0.0
  double output = 0.0; // Initialized with 0.0
  bool fOrC = true; // Initialized with true for Celsius by default
  List<String> conversionHistory = []; // List to store conversion history

  @override
  Widget build(BuildContext context) {
    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(str);
        } catch (e) {
          input = 0.0; // Handle invalid input
        }
      },
      decoration: InputDecoration(
        labelText:
            "Input a temperature value in ${fOrC == false ? "Fahrenheit" : "Celsius"}",
      ),
      textAlign: TextAlign.center,
    );

    AppBar appBar = AppBar(
      title: Text(
        "Climi's Temp Conversion App",
        style: TextStyle(color: Colors.white), // Set title text color
      ),
      backgroundColor: Colors.blue, // Brighter app bar background color
    );

    Container tempSwitch = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Text("F"),
          Radio<bool>(
            groupValue: fOrC,
            value: false,
            onChanged: (v) {
              setState(() {
                fOrC = v ?? false; // Default to false if null
              });
            },
          ),
          Text("C"),
          Radio<bool>(
            groupValue: fOrC,
            value: true,
            onChanged: (v) {
              setState(() {
                fOrC = v ?? true; // Default to true if null
              });
            },
          ),
        ],
      ),
    );

    Container calcBtn = Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Brighter button color
        ),
        child: Text("Convert"),
        onPressed: () {
          setState(() {
            // Perform the conversion
            if (fOrC == false) {
              output = (input - 32) * (5 / 9); // Fahrenheit to Celsius
              conversionHistory.add(
                  "${input.toStringAsFixed(2)} F = ${output.toStringAsFixed(2)} C");
            } else {
              output = (input * 9 / 5) + 32; // Celsius to Fahrenheit
              conversionHistory.add(
                  "${input.toStringAsFixed(2)} C = ${output.toStringAsFixed(2)} F");
            }
          });

          AlertDialog dialog = AlertDialog(
            content: fOrC == false
                ? Text(
                    "${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(2)} C")
                : Text(
                    "${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(2)} F"),
          );

          // Use builder instead of child for showDialog
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            inputField,
            tempSwitch,
            calcBtn,
            SizedBox(height: 20), // Space between the button and the list
            SizedBox(height: 20), // Additional space before the title
            Text(
              'Conversion History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(conversionHistory[index]),
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
