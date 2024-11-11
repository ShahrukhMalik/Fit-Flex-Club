import 'dart:io';

import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
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
            body: Form(
              key: formStateKey,
              child: Column(
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
                          controller: _nameController,
                          fieldType: TextFieldType.name,
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
                          "Password",
                          style:
                              TextStyle(color: Color(0xFFFFCD7C), fontSize: 18),
                        ),
                        ValueListenableBuilder(
                            valueListenable: passwordVisible,
                            builder: (context, visible, _) {
                              return AppTextFields.passwordTextField(
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
                            }),
                      ],
                    ),
                  ),
                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is AuthenticationComplete) {
                        context.read<ClientProfileBloc>().add(
                              AddUserClientProfileEvent(
                                clientEntity: ClientEntity(
                                  username: _emailController.text,
                                ),
                              ),
                            );
                      }
                      if (state is AuthenticationError) {}
                      if (state is AuthenticationLoading) {}
                    },
                    builder: (context, state) {
                      return PlatformButton().buildButton(
                        borderRadius: 100,
                        context: context,
                        isLoading: state is AuthenticationLoading,
                        type: ButtonType.primary,
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 94, 87, 86),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        text: "Sign Up",
                        onPressed: () {
                          if (formStateKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(
                                  CreateAccountAuthenticationEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
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
        ),
        BlocConsumer<ClientProfileBloc, ClientProfileState>(
          builder: (context, state) {
            if (state is ClientProfileLoading) {
              return FitFlexLoaderWidget(
                height: height,
                width: width,
              );
            }
            return SizedBox();
          },
          listener: (context, state) {
            if (state is ClientProfileComplete) {
              context.pushReplacement(
                FitFlexClientProfileSelectGenderPage.route,
              );
            }
          },
        )
      ],
    );
  }
}

class FitFlexLoaderWidget extends StatelessWidget {
  const FitFlexLoaderWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Color.fromARGB(143, 94, 87, 86),
      child: PlatformLoader().buildLoader(
        type: LoaderType.circular,
        size: 40,
        color: Color(0xFFFFCD7C),
      ),
    );
  }
}