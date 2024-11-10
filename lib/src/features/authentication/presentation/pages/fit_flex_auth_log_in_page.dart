import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitFlexAuthLogInPage extends StatelessWidget {
  static const String route = '/log_in_page';
  const FitFlexAuthLogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/fit_flex_image.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PlatformAppbar.basicAppBar(
              onLeadingPressed: () =>
                  context.pushReplacement(FitFlexAuthLandingPage.route),
              title: "Log In",
              context: context,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
