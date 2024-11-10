import 'package:flutter/material.dart';

class FitFlexAuthLandingPage extends StatelessWidget {
  static const String route = '/fit-flex-landing';
  const FitFlexAuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fit_flex_image.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            top: height * 0.09,
            left: 0,
            right: 0,
            // left: width * 0.2, // You can adjust this as needed
            child: SizedBox(
              child: Image.asset(
                'assets/images/fit_flex_text.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
