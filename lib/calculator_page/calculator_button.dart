import 'package:flutter/material.dart';

Widget buildButton(BuildContext context, String buttonText, Color buttonColor, void Function(String) onPressed, {IconData? icon}) {
  return Expanded(
    child: Container(
      height: MediaQuery.of(context).size.height*.096,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [buttonColor.withOpacity(0.7), buttonColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(20.0),
        ),
        child: icon != null
            ? Icon(icon, size: 24.0, color: Colors.white)
            : Text(
          buttonText,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () => onPressed(buttonText),
      ),
    ),
  );
}
