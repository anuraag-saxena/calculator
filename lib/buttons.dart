import 'package:flutter/material.dart';

class FirstButton extends StatelessWidget {
  final String buttonText;
  final buttonTapped;
  final bool mode;

  FirstButton(
      {required this.mode, required this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: (buttonText == '=' ||
                        buttonText == 'Del' ||
                        buttonText == 'AC')
                    ? Colors.white
                    : mode
                        ? Colors.white
                        : Colors.grey[900], //Color(0xFF7E7F81),
                fontSize: 30.0,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color:
                (buttonText == '=' || buttonText == 'Del' || buttonText == 'AC')
                    ? const Color(0xFFFF3724)
                    : mode
                        ? const Color(0xFF292B2F)
                        : Colors.grey[300],
            boxShadow: [
              BoxShadow(
                color: mode ? Colors.black : Colors.grey.shade600,
                offset: const Offset(5.0, 5.0),
                blurRadius: 20.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: mode ? Colors.grey.shade800 : Colors.white,
                offset: const Offset(-3.0, -3.0),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
