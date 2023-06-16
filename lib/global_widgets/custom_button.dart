import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.function,
  });

  final String text;
  final Color? color;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      height: 52,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          backgroundColor:
              (color == null) ? null : MaterialStateProperty.all<Color>(color!),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
        ),
      ),
    );
  }
}
