// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// /// A page that slides in from the right (iOS-style transition).
// class TransitionPage extends CustomTransitionPage<void> {
//   TransitionPage({
//     required LocalKey super.key,
//     required super.child,
//   }) : super(
//           transitionDuration: const Duration(milliseconds: 300),
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               SlideTransition(
//             position: animation.drive(
//               Tween<Offset>(
//                 begin: const Offset(1, 0), // Starts from the right
//                 end: Offset.zero, // Ends at the center
//               ).chain(_curveTween),
//             ),
//             child: child,
//           ),
//         );

//   static final CurveTween _curveTween = CurveTween(curve: Curves.easeInOut);
// }

import 'dart:io'; // For Platform check
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransitionPage<T> extends Page<T> {
  final Widget child;

  const TransitionPage({required LocalKey key, required this.child})
      : super(key: key);

  @override
  Route<T> createRoute(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageRoute<T>(settings: this, builder: (context) => child);
    } else {
      return MaterialPageRoute<T>(settings: this, builder: (context) => child);
    }
  }
}
