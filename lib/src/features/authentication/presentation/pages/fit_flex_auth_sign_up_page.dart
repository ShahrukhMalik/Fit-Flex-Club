import 'dart:ui';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/validators/textform_field_validators.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dropdown.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_phone_field.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/getgyms/getgyms_cubit.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/gym_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/trainer_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:flutter/cupertino.dart';
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
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  final ValueNotifier<List<Gym>> originalGyms = ValueNotifier([]);
  final ValueNotifier<Gym?> selectedGym = ValueNotifier(null);
  final ValueNotifier<Trainer?> selectedTrainer = ValueNotifier(null);
  final ValueNotifier<List<Trainer>> filteredTrainers = ValueNotifier([]);

  List<Map<String, String>> getGymOptions(List<Gym> gyms) {
    return gyms
        .map((gym) => {
              'name': gym.gymName,
              'id': gym.gymId,
            })
        .toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<GetGymsCubit>().getGyms();
    // selectedGym.addListener(
    //   () {
    //     selectedTrainer.value = null;
    //     filteredTrainers.value = [];
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return BlocListener<GetGymsCubit, GetGymsState>(
      listenWhen: (prev, current) => prev != current,
      listener: (context, state) {
        if (state is GetGymsInitial) {
          // Show loading
          PlatformDialog.showLoadingDialog(context: context);
        }

        if (state is GetGymsComplete) {
          // Hide loading

          originalGyms.value = state.gyms;
        }

        if (state is GetGymsError) {
          // Hide loading
          Navigator.of(context, rootNavigator: true)
              .pop(); // Close loader first
          PlatformDialog.showAlertDialog(
            context: context,
            title: 'Sign Up',
            message: state.failure.message ?? "Something went wrong",
          );
        }
      },
      child: PopScope(
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
                'assets/images/fit_flex_bg_wo_text.png',
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
            BlocBuilder<GetGymsCubit, GetGymsState>(
              builder: (context, state) {
                if (state is GetGymsLoading) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: globalColorScheme.primary,
                    ),
                  );
                }
                return Positioned(
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
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.1), // Semi-transparent
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Full Name",
                                        style: TextStyle(
                                            color: Color(0xFFFFCD7C),
                                            fontSize: 18),
                                      ),
                                      AppTextFields.basicTextField(
                                        hintText: "Enter your name",
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
                                            color: Color(0xFFFFCD7C),
                                            fontSize: 18),
                                      ),
                                      AppTextFields.basicTextField(
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
                                        "Gym",
                                        style: TextStyle(
                                            color: Color(0xFFFFCD7C),
                                            fontSize: 18),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 0,
                                        ),
                                        child:
                                            ValueListenableBuilder<List<Gym>>(
                                          valueListenable: originalGyms,
                                          builder: (context, gyms, _) {
                                            return PlatformSpecificDropdown(
                                              borderColor:
                                                  globalColorScheme.primary,
                                              downArrowColor:
                                                  globalColorScheme.primary,
                                              selectedOptionColor:
                                                  globalColorScheme.primary,
                                              pickerTitle: "Gym",
                                              options: getGymOptions(
                                                  originalGyms.value),
                                              initialValue:
                                                  selectedGym.value != null
                                                      ? {
                                                          'name': selectedGym
                                                              .value!.gymName,
                                                          'id': selectedGym
                                                              .value!.gymId,
                                                        }
                                                      : {
                                                          'name': 'Select Gym',
                                                          'id': '',
                                                        },
                                              onChanged: (selected) {
                                                final gym = originalGyms.value
                                                    .firstWhere((g) =>
                                                        g.gymId ==
                                                        selected['id']);
                                                selectedGym.value = gym;
                                                selectedTrainer.value = null;
                                                filteredTrainers.value =
                                                    gym.trainers;
                                              },
                                              onTap: (val) {
                                                // Optional: use if you want to log or track tap event
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Trainer",
                                        style: TextStyle(
                                            color: Color(0xFFFFCD7C),
                                            fontSize: 18),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 0,
                                        ),
                                        child: ValueListenableBuilder<
                                            List<Trainer>>(
                                          valueListenable: filteredTrainers,
                                          builder: (context, trainers, _) {
                                            return PlatformSpecificDropdown(
                                              borderColor:
                                                  globalColorScheme.primary,
                                              downArrowColor:
                                                  globalColorScheme.primary,
                                              selectedOptionColor:
                                                  globalColorScheme.primary,
                                              key: UniqueKey(),
                                              pickerTitle: "Trainer",
                                              options: filteredTrainers.value
                                                  .map((trainer) => {
                                                        'name':
                                                            trainer.trainerName,
                                                        'id': trainer.trainerId,
                                                      })
                                                  .toList(),
                                              initialValue:
                                                  selectedTrainer.value != null
                                                      ? {
                                                          'name':
                                                              selectedTrainer
                                                                  .value!
                                                                  .trainerName,
                                                          'id': selectedTrainer
                                                              .value!.trainerId,
                                                        }
                                                      : {
                                                          'name':
                                                              'Select Trainer',
                                                          'id': '',
                                                        },
                                              onChanged: (selected) {
                                                final trainer = filteredTrainers
                                                    .value
                                                    .firstWhere((t) =>
                                                        t.trainerId ==
                                                        selected['id']);
                                                selectedTrainer.value = trainer;
                                              },
                                              onTap: (val) {},
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Phone",
                                        style: TextStyle(
                                            color: Color(0xFFFFCD7C),
                                            fontSize: 18),
                                      ),
                                      CustomPhoneField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
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
                                        "Enter Password",
                                        style: TextStyle(
                                            color: Color(0xFFFFCD7C),
                                            fontSize: 18),
                                      ),
                                      AppTextFields.passwordTextField(
                                        validator: passwordValidator,
                                        showVisibilityIcon: false,
                                        controller: _passwordController,
                                        obscureText: true,
                                        onToggleVisibility: () {},
                                        boxDecoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFCD7C),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Confirm Password",
                                        style: TextStyle(
                                          color: Color(0xFFFFCD7C),
                                          fontSize: 18,
                                        ),
                                      ),
                                      AppTextFields.passwordTextField(
                                        validator: (text) {
                                          return confirmPasswordValidator(
                                            _passwordController.text,
                                            text,
                                          );
                                        },
                                        showVisibilityIcon: false,
                                        controller: _confirmPasswordController,
                                        obscureText: false,
                                        onToggleVisibility: () {},
                                        boxDecoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFCD7C),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BlocConsumer<AuthenticationBloc,
                                    AuthenticationState>(
                                  listener: (context, state) {
                                    if (state is AuthenticationComplete) {
                                      context.read<ClientProfileBloc>().add(
                                            AddUserClientProfileEvent(
                                              gym: selectedGym.value!,
                                              trainer: selectedTrainer.value!,
                                              clientEntity: ClientEntity(
                                                phone: {
                                                  "countryCode": _codeController
                                                          .text.isEmpty
                                                      ? "+92"
                                                      : _codeController.text,
                                                  "phoneNumber":
                                                      _phoneController.text,
                                                },
                                                username:
                                                    _nameController.text.trim(),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: PlatformButton().buildButton(
                                        backgroundColor: Color(0xFFFFCD7C),
                                        borderRadius: 100,
                                        context: context,
                                        isLoading:
                                            state is AuthenticationLoading,
                                        type: ButtonType.primary,
                                        textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 94, 87, 86),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        text: "Sign Up",
                                        onPressed: () {
                                          if (formStateKey.currentState!
                                              .validate()) {
                                            context
                                                .read<AuthenticationBloc>()
                                                .add(
                                                  CreateAccountAuthenticationEvent(
                                                    email:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                  ),
                                                );
                                          }
                                        },
                                        width: double.maxFinite,
                                      )!,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
