import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A page that fades in an out.
class TransitionPage extends CustomTransitionPage<void> {
  /// Creates a [TransitionPage].
  TransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 700),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation.drive(_curveTween), child: child,
            // SlideTransition(
            //   position: animation.drive(
            //     Tween<Offset>(
            //       begin: const Offset(300, 0),
            //       end: const Offset(0, 0),
            //     ).chain(_curveTween),
            //   ),
            //   child: child,
            // ),
          ),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
