import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            child: SizedBox(
              child: Image.asset(
                'assets/images/fit_flex_text.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.05,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PlatformButton().buildButton(
                  borderRadius: 100,
                  context: context,
                  type: ButtonType.primary,
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 94, 87, 86),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  text: "Log In",
                  onPressed: () => context.go(FitFlexAuthLogInPage.route),
                  width: width * 0.6,
                  textPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.3,
                  ),
                )!,
                const SizedBox(height: 16), // Space between buttons
                PlatformButton().buildButton(
                  borderRadius: 100,
                  textPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.3,
                  ),
                  context: context,
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 94, 87, 86),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  type: ButtonType
                      .primary, // Assuming you have a secondary button type
                  text: "Sign Up",
                  onPressed: () => context.go(FitFlexAuthSignUpPage.route),
                  width: width * 0.6,
                )!,
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
