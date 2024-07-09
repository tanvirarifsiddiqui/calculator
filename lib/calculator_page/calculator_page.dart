import 'package:flutter/material.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _expression = "";
  String _operand = "";
  double _num1 = 0.0;
  double _num2 = 0.0;

  String _formatOutput(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "/" ||
          buttonText == "*" ||
          buttonText == "√" ||
          buttonText == "^" ||
          buttonText == "n√") {
        if (_output == "0") {
          return;
        }

        if (_operand.isNotEmpty && _output != "0") {
          _num2 = double.parse(_output);
          _num1 = _calculateResult();
          _output = _formatOutput(_num1);
        } else {
          _num1 = double.parse(_output);
        }

        _operand = buttonText;
        _expression = _operand == "√"
            ? "$_operand${_formatOutput(_num1)}"
            : "${_formatOutput(_num1)} $_operand";
        _output = "0";
      } else if (buttonText == ".") {
        if (_output.contains(".")) {
          return;
        } else {
          _output = _output + buttonText;
        }
      } else if (buttonText == "=" ) {
        _num2 = double.parse(_output);
        _expression = "$_expression ${_formatOutput(_num2)}";
        double? result = _calculateResult();
        _output = _formatOutput(result);
        _num1 = result;
        _num2 = 0.0;
        _operand = "";
      } else if (buttonText == "←") {
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "0";
        }
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output = _output + buttonText;
        }
        _output = _formatOutput(double.parse(_output));
      }
    });
  }

  double _calculateResult() {
    double? result;
    if (_operand == "+") {
      result = _num1 + _num2;
    } else if (_operand == "-") {
      result = _num1 - _num2;
    } else if (_operand == "*") {
      result = _num1 * _num2;
    } else if (_operand == "/") {
      result = _num1 / _num2;
    } else if (_operand == "√") {
      result = sqrt(_num1);
    } else if (_operand == "^") {
      result = pow(_num1, _num2) as double?;
    } else if (_operand == "n√") {
      result = pow(_num1, 1 / _num2) as double?;
    } else {
      result = 0.0;
    }
    return result!;
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton("C"),
                      SizedBox(width: 5,),
                      buildButton("√"),
                      SizedBox(width: 5,),
                      buildButton("←"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("7"),
                      SizedBox(width: 5,),
                      buildButton("8"),
                      SizedBox(width: 5,),
                      buildButton("9"),
                      SizedBox(width: 5,),
                      buildButton("/"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("4"),
                      SizedBox(width: 5,),
                      buildButton("5"),
                      SizedBox(width: 5,),
                      buildButton("6"),
                      SizedBox(width: 5,),
                      buildButton("*"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("1"),
                      SizedBox(width: 5,),
                      buildButton("2"),
                      SizedBox(width: 5,),
                      buildButton("3"),
                      SizedBox(width: 5,),
                      buildButton("-"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("."),
                      SizedBox(width: 5,),
                      buildButton("0"),
                      SizedBox(width: 5,),
                      buildButton("00"),
                      SizedBox(width: 5,),
                      buildButton("+"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("^"),
                      SizedBox(width: 5,),
                      buildButton("n√"),
                      SizedBox(width: 5,),
                      buildButton("="),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
