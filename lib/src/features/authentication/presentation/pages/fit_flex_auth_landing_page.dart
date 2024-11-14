import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitFlexAuthLandingPage extends StatefulWidget {
  final bool? isUserActive;
  final bool? isUserLoggedOut;
  static const String route = '/fit-flex-landing/:flag';
  const FitFlexAuthLandingPage({
    super.key,
    this.isUserActive,
    this.isUserLoggedOut,
  });

  @override
  State<FitFlexAuthLandingPage> createState() => _FitFlexAuthLandingPageState();
}

class _FitFlexAuthLandingPageState extends State<FitFlexAuthLandingPage> {
  @override
  void initState() {
    // TODO: implement initState

    if (widget.isUserActive != null && !widget.isUserActive!) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          PlatformDialog.showAlertDialog(
            context: context,
            title: "Account Inactive",
            message: "Your Account is not active!",
          );
        },
      );
    }
  }

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
                  width: width * 0.8,
                  backgroundColor: Color(0xFFFFCD7C),
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
                )!,
                const SizedBox(height: 16), // Space between buttons
                PlatformButton().buildButton(
                  width: width * 0.85,
                  borderRadius: 100,
                  context: context,
                  backgroundColor: Color(0xFFFFCD7C),
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 94, 87, 86),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  type: ButtonType
                      .primary, // Assuming you have a secondary button type
                  text: "Sign Up",
                  onPressed: () => context.go(FitFlexAuthSignUpPage.route),
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
