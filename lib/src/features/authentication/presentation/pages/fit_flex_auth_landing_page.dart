import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
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

    return Stack(
      children: [
        Positioned.fill(
          // top: 50,
          child: Image.asset(
            'assets/images/fit_flex_bg_with_text.png',
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PlatformAppbar.basicAppBar(
            // onLeadingPressed: () => context.go('/'),
            title: "Welcome",
            context: context,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              // Positioned(
              //   top: height * 0.15,
              //   left: 0,
              //   right: 0,
              //   child: SizedBox(
              //     child: Image.asset(
              //       'assets/images/fit_flex_text.png',
              //       fit: BoxFit.fill,
              //       alignment: Alignment.center,
              //     ),
              //   ),
              // ),
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
                      onPressed: () => context.push(
                          '${FitFlexAuthLandingPage.route}/${FitFlexAuthLogInPage.route}'),
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
                      onPressed: () => context.push(
                          '${FitFlexAuthLandingPage.route}/${FitFlexAuthSignUpPage.route}'),
                    )!,
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
