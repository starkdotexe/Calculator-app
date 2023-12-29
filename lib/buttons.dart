import 'package:flutter/material.dart';

class CalcButtons extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback buttonTapped;

  const CalcButtons({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        borderRadius: BorderRadius.circular(50),
        onTap: buttonTapped,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(color: buttonTextColor, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
