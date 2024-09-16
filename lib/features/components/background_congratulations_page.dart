import 'package:flutter/material.dart';

class BackgroundCongratulationsPage extends StatelessWidget {
  final Widget child;
  const BackgroundCongratulationsPage({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
