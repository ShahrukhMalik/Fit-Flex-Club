// import 'package:flutter/material.dart';
// import 'package:injectable/injectable.dart';

// ///navigator service for the application
// @lazySingleton
// class NavigationService {
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
//     return navigatorKey.currentState!
//         .pushNamed(routeName, arguments: arguments);
//   }

//   void goBack() {
//     return navigatorKey.currentState!.pop();
//   }
// }
