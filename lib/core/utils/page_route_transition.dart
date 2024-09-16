import 'package:flutter/cupertino.dart';

Route scaleIn(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = 0.3;
      var end = 1.0;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: animation.drive(Tween(begin: .65, end: 1.0).chain(CurveTween(curve: curve))),
        child: ScaleTransition(
          scale: animation.drive(tween),
          child: page,
        ),
      );
    },
  );
}