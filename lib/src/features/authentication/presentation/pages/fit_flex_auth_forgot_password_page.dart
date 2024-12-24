import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexAuthForgotPasswordPage extends StatefulWidget {
  static const String route = 'forgot-password';
  const FitFlexAuthForgotPasswordPage({super.key});

  @override
  State<FitFlexAuthForgotPasswordPage> createState() =>
      _FitFlexAuthForgotPasswordPageState();
}

class _FitFlexAuthForgotPasswordPageState
    extends State<FitFlexAuthForgotPasswordPage> {
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
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
          PopScope(
            canPop: true,
            child: Positioned(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PlatformAppbar.basicAppBar(
                  onLeadingPressed: () => context.pop(),
                  title: "Forgot Password",
                  context: context,
                  backgroundColor: Colors.transparent,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Form(
                        key: formStateKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: AppTextFields.basicTextField(
                          hintText: "Enter your email address",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: BlocConsumer<AuthenticationBloc,
                            AuthenticationState>(
                          listener: (context, state) {
                            if (state is AuthenticationComplete) {
                              if (state.entity?.mailSent ?? false) {
                                context.go(FitFlexAuthLogInPage.route);
                              }
                            }
                            if (state is AuthenticationError) {
                              PlatformDialog.showAlertDialog(
                                context: context,
                                title: "Forgot Password",
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
                              text: "Send Email",
                              onPressed: () {
                                if (formStateKey.currentState!.validate()) {
                                  context.read<AuthenticationBloc>().add(
                                        ForgotPasswordAuthenticationEvent(
                                          email: _emailController.text,
                                        ),
                                      );
                                }
                              },
                              width: double.maxFinite,
                            )!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
