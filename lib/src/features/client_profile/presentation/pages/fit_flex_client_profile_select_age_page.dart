import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitFlexClientProfileSelectAgePage extends StatefulWidget {
  final String gender;
  static const String route = "/select-age";
  const FitFlexClientProfileSelectAgePage({
    super.key,
    required this.gender,
  });

  @override
  State<FitFlexClientProfileSelectAgePage> createState() =>
      _FitFlexClientProfileSelectAgePageState();
}

class _FitFlexClientProfileSelectAgePageState
    extends State<FitFlexClientProfileSelectAgePage> {
  final ValueNotifier<String> ageSelected = ValueNotifier<String>("");
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.go(FitFlexClientProfileSelectGenderPage.route);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "What is your age?",
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
                          "This is used in getting personlized results and plans",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: ageSelected,
                        builder: (context, age, _) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Text(
                              "$age yrs",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.4,
                        child: FitFlexScrollWheelWidget(
                          selectedValue: ageSelected,
                          maxCount: 149,
                        ),
                      ),
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
                      onPressed: () => context
                          .go(FitFlexClientProfileSelectGenderPage.route),
                    )!,
                    PlatformButton().buildButton(
                      backgroundColor: Color(0xFFFFC26A),
                      foregroundColor: Color(0xFFF2F2F7),
                      context: context,
                      type: ButtonType.iconText,
                      icon: Icons.arrow_forward_ios,
                      text: "Continue",
                      onPressed: () => context.go(
                        FitFlexClientProfileSelectWeightPage.route,
                        extra: {
                          "gender": widget.gender,
                          "age": ageSelected.value,
                        },
                      ),
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
