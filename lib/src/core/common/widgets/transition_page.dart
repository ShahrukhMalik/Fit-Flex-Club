import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A page that slides in from the right (iOS-style transition).
class TransitionPage extends CustomTransitionPage<void> {
  TransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0), // Starts from the right
                end: Offset.zero, // Ends at the center
              ).chain(_curveTween),
            ),
            child: child,
          ),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeInOut);
}
