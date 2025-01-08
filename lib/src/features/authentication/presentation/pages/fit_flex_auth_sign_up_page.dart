import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_phone_field.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexAuthSignUpPage extends StatefulWidget {
  static const String route = 'sign_up_page';
  const FitFlexAuthSignUpPage({super.key});

  @override
  State<FitFlexAuthSignUpPage> createState() => _FitFlexAuthSignUpPageState();
}

class _FitFlexAuthSignUpPageState extends State<FitFlexAuthSignUpPage> {
  final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(true);
  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          PlatformDialog.showAlertDialog(
            context: context,
            title: "Workout Tracker",
            message:
                "Progress is not saved, if you continue your progress will be lost.",
            cancelText: 'Cancel',
            confirmText: 'Continue',
            onConfirm: () => context.pop(),
          );
        }
      },
      child: Stack(
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
                onLeadingPressed: () => context.pop(),
                title: "Create Account",
                context: context,
                backgroundColor: Colors.transparent,
              ),
              body: Form(
                key: formStateKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name",
                              style: TextStyle(
                                  color: Color(0xFFFFCD7C), fontSize: 18),
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
                              style: TextStyle(
                                  color: Color(0xFFFFCD7C), fontSize: 18),
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
                              "Phone",
                              style: TextStyle(
                                  color: Color(0xFFFFCD7C), fontSize: 18),
                            ),
                            CustomPhoneField(
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              onCountrySelect: (p0) {
                                _codeController.text = p0.toString();
                                return null;
                              },
                              controller: _phoneController,
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
                              style: TextStyle(
                                  color: Color(0xFFFFCD7C), fontSize: 18),
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
                                      phone: {
                                        "countryCode":
                                            _codeController.text.isEmpty
                                                ? "+92"
                                                : _codeController.text,
                                        "phoneNumber": _phoneController.text,
                                      },
                                      username: _nameController.text.trim(),
                                      email: _emailController.text,
                                      isUserActive: true,
                                    ),
                                  ),
                                );
                          }
                          if (state is AuthenticationError) {
                            PlatformDialog.showAlertDialog(
                              context: context,
                              title: "Create Account",
                              message: state.failures.message ??
                                  "Something went wrong!",
                            );
                          }
                          if (state is AuthenticationLoading) {}
                        },
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: PlatformButton().buildButton(
                              backgroundColor: Color(0xFFFFCD7C),
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
                            )!,
                          );
                        },
                      ),
                    ],
                  ),
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
              if (state is ClientProfileError) {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Create Account",
                  message: state.failures.message ?? "Something went wrong!",
                );
              }
            },
          )
        ],
      ),
    );
  }
}

// class FitFlexLoaderPage extends StatelessWidget {
//   static const String route = '/fit_flex_loader';
//   const FitFlexLoaderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/fit_flex_image.png',
//               fit: BoxFit.cover,
//               alignment: Alignment.center,
//             ),
//           ),
//           // Positioned.fill(
//           //   child:
//           FitFlexLoaderWidget(
//             height: height,
//             width: width,
//           ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

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
