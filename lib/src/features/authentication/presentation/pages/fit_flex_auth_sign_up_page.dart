import 'dart:io';

import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexAuthSignUpPage extends StatefulWidget {
  static const String route = '/sign_up_page';
  const FitFlexAuthSignUpPage({super.key});

  @override
  State<FitFlexAuthSignUpPage> createState() => _FitFlexAuthSignUpPageState();
}

class _FitFlexAuthSignUpPageState extends State<FitFlexAuthSignUpPage> {
  final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
              title: "Create Account",
              context: context,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
                        style:
                            TextStyle(color: Color(0xFFFFCD7C), fontSize: 18),
                      ),
                      AppTextFields.basicTextField(
                        boxDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: Color(0xFFFFCD7C),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email",
                        style:
                            TextStyle(color: Color(0xFFFFCD7C), fontSize: 18),
                      ),
                      AppTextFields.basicTextField(
                        boxDecoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: Color(0xFFFFCD7C),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style:
                            TextStyle(color: Color(0xFFFFCD7C), fontSize: 18),
                      ),
                      ValueListenableBuilder(
                          valueListenable: passwordVisible,
                          builder: (context, visible, _) {
                            return AppTextFields.passwordTextField(
                              obscureText: visible,
                              onToggleVisibility: () =>
                                  passwordVisible.value = !visible,
                              boxDecoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color(0xFFFFCD7C),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return PlatformButton().buildButton(
                      borderRadius: 100,
                      context: context,
                      type: ButtonType.primary,
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 94, 87, 86),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      text: "Sign Up",
                      onPressed: () => context.go(FitFlexAuthLogInPage.route),
                      width: double.maxFinite,
                      textPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.3,
                      ),
                    )!;
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
