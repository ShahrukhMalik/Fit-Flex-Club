import 'dart:ui';

import 'package:fit_flex_club/src/core/common/validators/textform_field_validators.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_forgot_password_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexAuthLogInPage extends StatefulWidget {
  static const String route = 'log_in_page';
  const FitFlexAuthLogInPage({super.key});

  @override
  State<FitFlexAuthLogInPage> createState() => _FitFlexAuthLogInPageState();
}

class _FitFlexAuthLogInPageState extends State<FitFlexAuthLogInPage> {
  final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(true);
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/fit_flex_bg_wo_text.png',
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PlatformAppbar.basicAppBar(
                onLeadingPressed: () => context.go('/'),
                title: "Log In",
                context: context,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: true),
            body: Form(
              key: formStateKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              Colors.white.withOpacity(0.1), // Semi-transparent
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Welcome to Fit Blitz",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: Color(0xFFFFCD7C), fontSize: 18),
                              ),
                              AppTextFields.basicTextField(
                                textAlign: TextAlign.start,
                                hintText: "Enter your email",
                                fieldType: TextFieldType.email,
                                controller: _emailController,
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
                                "Enter Password",
                                style: TextStyle(
                                    color: Color(0xFFFFCD7C), fontSize: 18),
                              ),
                              ValueListenableBuilder(
                                valueListenable: passwordVisible,
                                builder: (context, visible, _) {
                                  return AppTextFields.passwordTextField(
                                    validator: passwordValidator,
                                    controller: _passwordController,
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
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child:
                          BlocConsumer<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state is AuthenticationComplete) {
                            if (state.entity?.isLoggedIn ?? false) {
                              if (!state.rebuild!) {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(ListenToEvents());
                              }
                            }
                          }
                          if (state is AuthenticationError) {
                            PlatformDialog.showAlertDialog(
                              context: context,
                              title: "Log In",
                              message: state.failures.message ??
                                  "Something went wrong!",
                            );
                          }
                          if (state is AuthenticationLoading) {}
                        },
                        builder: (context, state) {
                          return PlatformButton().buildButton(
                            borderRadius: 100,
                            context: context,
                            isLoading: state is AuthenticationLoading,
                            type: ButtonType.primary,
                            backgroundColor: Color(0xFFFFCD7C),
                            textStyle: TextStyle(
                              color: Color.fromARGB(255, 94, 87, 86),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            text: "Log In",
                            onPressed: () {
                              if (formStateKey.currentState!.validate()) {
                                context.read<AuthenticationBloc>().add(
                                      LogInAuthenticationEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            width: double.maxFinite,
                          )!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlatformButton().buildButton(
                        borderRadius: 100,
                        context: context,
                        type: ButtonType.primary,
                        backgroundColor: Colors.transparent,
                        textStyle: TextStyle(
                          color: Color(0xFFFFCD7C),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        text: "Forgot Password ?",
                        onPressed: () {
                          context.push(
                            '${FitFlexAuthLandingPage.route}/${FitFlexAuthLogInPage.route}/${FitFlexAuthForgotPasswordPage.route}',
                          );
                        },
                        width: double.maxFinite,
                      )!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
