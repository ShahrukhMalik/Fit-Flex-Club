import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
import 'package:flutter/material.dart';

// class FitFlexClientProfileSelectHeightPage extends StatelessWidget {
//   final String gender;
//   final String age;
//   final String weight;
//   static const String route = "/select-height";

//   const FitFlexClientProfileSelectHeightPage({
//     super.key,
//     required this.gender,
//     required this.age,
//     required this.weight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class FitFlexClientProfileSelectHeightPage extends StatefulWidget {
  final String gender;
  final String age;
  final String weight;
  static const String route = "/select-height";
  const FitFlexClientProfileSelectHeightPage({
    super.key,
    required this.gender,
    required this.age,
    required this.weight,
  });

  @override
  State<FitFlexClientProfileSelectHeightPage> createState() =>
      _FitFlexClientProfileSelectHeightPageState();
}

class _FitFlexClientProfileSelectHeightPageState
    extends State<FitFlexClientProfileSelectHeightPage> {
  final ValueNotifier<String> heightSelected = ValueNotifier<String>("");
  final ValueNotifier<String> metricSelected = ValueNotifier<String>("");
  final ValueNotifier<bool> isFirstMetricSelected = ValueNotifier<bool>(true);

  final List<String> metrics = ['ft', 'cm'];

  @override
  void initState() {
    metricSelected.value = metrics[0];
    isFirstMetricSelected.addListener(
      () {
        if (isFirstMetricSelected.value) {
          metricSelected.value = metrics[0];
        } else {
          metricSelected.value = metrics[1];
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    AnimatedSwitch(
                      isFirstMetricSelected: isFirstMetricSelected,
                      metrics: metrics,
                    ),
                    ValueListenableBuilder(
                      valueListenable: metricSelected,
                      builder: (context, metric, _) {
                        return Column(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: heightSelected,
                              builder: (context, age, _) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: Text(
                                    "$age " "$metric",
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
                                selectedValue: heightSelected,
                                maxCount: 1499,
                                metric: metric,
                              ),
                            ),
                          ],
                        );
                      },
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
                    onPressed: () {},
                  )!,
                  PlatformButton().buildButton(
                    backgroundColor: Color(0xFFFFC26A),
                    foregroundColor: Color(0xFFF2F2F7),
                    context: context,
                    type: ButtonType.iconText,
                    icon: Icons.arrow_forward_ios,
                    text: "Continue",
                    onPressed: () {
                      PlatformDialog.showAlertDialog(
                        context: context,
                        title: "Sign Up",
                        message: "Please select Gender before you proceed.",
                      );
                    },
                  )!
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
