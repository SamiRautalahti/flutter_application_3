import "package:flutter/material.dart";

PageRouteBuilder pageTransitionBuilder(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondatyAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final opacity = animation.drive(Tween<double>(begin: 0, end: 1));

      return FadeTransition(opacity: opacity, child: child);
    },
  );
}
