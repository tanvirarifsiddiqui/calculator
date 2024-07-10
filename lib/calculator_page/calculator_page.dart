import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';
import '../app_constants.dart';
import 'calculator_button.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _expression = "";

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

          if (eval == double.infinity || eval == -double.infinity) {
            _output = "∞";
          } else if (eval == eval.truncate()) {
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
            if (sqrtValue == double.infinity || sqrtValue == -double.infinity) {
              _output = "∞";
            } else if (sqrtValue == sqrtValue.truncate()) {
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
          if (squaredValue == double.infinity || squaredValue == -double.infinity) {
            _output = "∞";
          } else if (squaredValue == squaredValue.truncate()) {
            _output = squaredValue.truncate().toString();
          } else {
            _output = squaredValue.toString();
          }
        } catch (e) {
          _output = "Error";
        }
      } else if (buttonText == "π") {
        if (_output == "0") {
          _output = pi.toString();
        } else if (RegExp(r'\d$').hasMatch(_output)) {
          _output += "×π";
        } else {
          _output += "π";
        }
      } else if (buttonText == "(") {
        if (_output == "0" || RegExp(r'[×÷\-\+\(]$').hasMatch(_output)) {
          _output += "(";
        } else if (RegExp(r'\d$').hasMatch(_output)) {
          _output += "×(";
        } else {
          _output += "(";
        }
      } else if (buttonText == ")") {
        _output += ")";
      } else if (buttonText == ".") {
        if (!_output.split(RegExp(r'[×÷\-\+\(\)]')).last.contains(".")) {
          _output += ".";
        }
      } else {
        if (_output == "0" && buttonText != ".") {
          _output = buttonText;
        } else {
          if (_output.length < 50) {
            _output += buttonText;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.blue.shade100,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 24.0,
                    right: 12.0,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 24),
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton("C", const Color(0xFFFF0303), buttonPressed),
                    buildButton("√", Colors.grey.shade800, buttonPressed),
                    buildButton("←", Colors.grey.shade800, buttonPressed, icon: Icons.backspace),
                    buildButton("÷", Colors.orange.shade800, buttonPressed),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", AppConstants.secondaryColor, buttonPressed),
                    buildButton("8", AppConstants.secondaryColor, buttonPressed),
                    buildButton("9", AppConstants.secondaryColor, buttonPressed),
                    buildButton("×", Colors.orange.shade800, buttonPressed),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", AppConstants.secondaryColor, buttonPressed),
                    buildButton("5", AppConstants.secondaryColor, buttonPressed),
                    buildButton("6", AppConstants.secondaryColor, buttonPressed),
                    buildButton("-", Colors.orange.shade800, buttonPressed),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", AppConstants.secondaryColor, buttonPressed),
                    buildButton("2", AppConstants.secondaryColor, buttonPressed),
                    buildButton("3", AppConstants.secondaryColor, buttonPressed),
                    buildButton("+", Colors.orange.shade800, buttonPressed),
                  ],
                ),
                Row(
                  children: [
                    buildButton(".", AppConstants.secondaryColor, buttonPressed),
                    buildButton("0", AppConstants.secondaryColor, buttonPressed),
                    buildButton("00", AppConstants.secondaryColor, buttonPressed),
                    buildButton("=", const Color(0xFF00A667), buttonPressed),
                  ],
                ),
                Row(
                  children: [
                    buildButton("n²", Colors.grey.shade800, buttonPressed),
                    buildButton("π", Colors.grey.shade800, buttonPressed),
                    buildButton("(", Colors.grey.shade800, buttonPressed),
                    buildButton(")", Colors.grey.shade800, buttonPressed),
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
