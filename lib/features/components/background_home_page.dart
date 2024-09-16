import 'package:flutter/material.dart';

class BackgroundHomePage extends StatelessWidget {
  final Widget child;
  const BackgroundHomePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pic.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }
}
