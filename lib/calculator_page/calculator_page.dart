import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _expression = "";
  final ScrollController _scrollController = ScrollController();

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
      } else if (buttonText == "←") {
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "0";
        }
      } else if (buttonText == "=") {
        _expression = _output;
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(_expression.replaceAll('×', '*').replaceAll('÷', '/').replaceAll('√', 'sqrt').replaceAll('π', pi.toString()));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          // Check if the result is an integer
          if (eval == eval.truncate()) {
            _output = eval.truncate().toString();
          } else {
            _output = eval.toString();
          }
        } catch (e) {
          _output = "Error";
        }
      } else if (buttonText == "√") {
        _expression += "√" + _output;
        try {
          double value = double.parse(_output);
          if (value < 0) {
            _output = "Error";
          } else {
            double sqrtValue = sqrt(value);
            // Check if the result is an integer
            if (sqrtValue == sqrtValue.truncate()) {
              _output = sqrtValue.truncate().toString();
            } else {
              _output = sqrtValue.toString();
            }
          }
        } catch (e) {
          _output = "Error";
        }
      } else if (buttonText == "n²") {
        try {
          double value = double.parse(_output);
          double squaredValue = value * value;
          // Check if the result is an integer
          if (squaredValue == squaredValue.truncate()) {
            _output = squaredValue.truncate().toString();
          } else {
            _output = squaredValue.toString();
          }
        } catch (e) {
          _output = "Error";
        }
      } else if (buttonText == "π") {
        _output += "π";
      } else {
        if (_output == "0" && buttonText != ".") {
          _output = buttonText;
        } else {
          if (_output.length < 50) {
            _output += buttonText;
          }
        }
      }

      // Scroll to bottom
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      _expression,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(
                      _output,
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      minFontSize: 20,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton("C", Colors.redAccent),
                    buildButton("√", Colors.orangeAccent),
                    buildButton("←", Colors.orangeAccent),
                    buildButton("÷", Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", Colors.teal),
                    buildButton("8", Colors.teal),
                    buildButton("9", Colors.teal),
                    buildButton("×", Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", Colors.teal),
                    buildButton("5", Colors.teal),
                    buildButton("6", Colors.teal),
                    buildButton("-", Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", Colors.teal),
                    buildButton("2", Colors.teal),
                    buildButton("3", Colors.teal),
                    buildButton("+", Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    buildButton(".", Colors.teal),
                    buildButton("0", Colors.teal),
                    buildButton("00", Colors.teal),
                    buildButton("=", Colors.green),
                  ],
                ),
                Row(
                  children: [
                    buildButton("n²", Colors.orangeAccent),
                    buildButton("π", Colors.orangeAccent),
                    buildButton("(", Colors.orangeAccent),
                    buildButton(")", Colors.orangeAccent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
