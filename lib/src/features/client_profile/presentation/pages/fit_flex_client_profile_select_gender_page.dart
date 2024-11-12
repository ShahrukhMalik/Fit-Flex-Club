import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_age_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_height_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitFlexClientProfileSelectGenderPage extends StatefulWidget {
  static const String route = "/select-gender";
  const FitFlexClientProfileSelectGenderPage({super.key});

  @override
  State<FitFlexClientProfileSelectGenderPage> createState() =>
      _FitFlexClientProfileSelectGenderPageState();
}

class _FitFlexClientProfileSelectGenderPageState
    extends State<FitFlexClientProfileSelectGenderPage> {
  final ValueNotifier<String> selectedButton = ValueNotifier("");
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.go(FitFlexAuthLandingPage.route);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "How do you identify?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Text(
                          "To give you a better experience we need to know your gender",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: selectedButton,
                        builder: (context, button, _) {
                          final Color bgColor = button == "Male"
                              ? Color(0xFFFFC26A)
                              : Color(0xFFF2F2F7);
                          final Color fgColor = button == "Male"
                              ? Color(0xFFF2F2F7)
                              : Color(0xFFFFC26A);
                          return PlatformButton().buildButton(
                            width: width,
                            context: context,
                            type: ButtonType.primary,
                            backgroundColor: bgColor,
                            foregroundColor: fgColor,
                            textStyle: TextStyle(
                              color: fgColor,
                            ),
                            text: "Male",
                            onPressed: () => selectedButton.value = "Male",
                          )!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: selectedButton,
                        builder: (context, button, _) {
                          final Color bgColor = button == "Female"
                              ? Color(0xFFFFC26A)
                              : Color(0xFFF2F2F7);
                          final Color fgColor = button == "Female"
                              ? Color(0xFFF2F2F7)
                              : Color(0xFFFFC26A);
                          return PlatformButton().buildButton(
                            width: width,
                            context: context,
                            type: ButtonType.primary,
                            backgroundColor: bgColor,
                            foregroundColor: fgColor,
                            textStyle: TextStyle(
                              color: fgColor,
                            ),
                            text: "Female",
                            onPressed: () => selectedButton.value = "Female",
                          )!;
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PlatformButton().buildButton(
                      foregroundColor: Color(0xFFFFC26A),
                      backgroundColor: Colors.transparent,
                      textStyle: TextStyle(
                        color: Color(0xFFFFC26A),
                      ),
                      context: context,
                      type: ButtonType.iconText,
                      icon: Icons.arrow_back_ios_new,
                      iconAlignment: IconAlignment.start,
                      text: "Previous",
                      onPressed: () => context.go(FitFlexAuthLandingPage.route),
                    )!,
                    PlatformButton().buildButton(
                      backgroundColor: Color(0xFFFFC26A),
                      foregroundColor: Color(0xFFF2F2F7),
                      context: context,
                      type: ButtonType.iconText,
                      icon: Icons.arrow_forward_ios,
                      text: "Continue",
                      onPressed: () {
                        if (selectedButton.value.isEmpty) {
                          PlatformDialog.showAlertDialog(
                            context: context,
                            title: "Sign Up",
                            message: "Please select Gender before you proceed.",
                          );
                        } else {
                          context.go(
                            FitFlexClientProfileSelectAgePage.route,
                            extra: {
                              "gender": selectedButton.value,
                            },
                          );
                        }
                      },
                    )!
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedSwitch extends StatefulWidget {
  final ValueNotifier<bool> isFirstMetricSelected;
  final List<String> metrics;
  const AnimatedSwitch({
    super.key,
    required this.isFirstMetricSelected,
    required this.metrics,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  void toggleWeightUnit() {
    widget.isFirstMetricSelected.value = !widget.isFirstMetricSelected.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.isFirstMetricSelected,
        builder: (context, isFirstMetricSelected, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: toggleWeightUnit,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 72,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade200,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedAlign(
                          duration: Duration(milliseconds: 300),
                          alignment: isFirstMetricSelected
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            width: 34,
                            height: 34,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                widget.metrics[0],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                widget.metrics[1],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
