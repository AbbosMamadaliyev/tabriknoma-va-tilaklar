import 'package:flutter/material.dart';

class CustomCardCongratulations extends StatelessWidget {
  final Widget child;
  const CustomCardCongratulations({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        color: Colors.deepPurple.withOpacity(0.6),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
