import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
import 'package:fit_flex_club/src/features/dashboard/presentation/pages/fit_flex_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  final String weightUnit;
  static const String route = "/select-height";
  const FitFlexClientProfileSelectHeightPage({
    super.key,
    required this.gender,
    required this.age,
    required this.weight,
    required this.weightUnit,
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
  final FixedExtentScrollController fixedExtentScrollController =
      FixedExtentScrollController(initialItem: 4);

  final List<String> metrics = ['ft', 'cm'];

  void _scrollToIndex(int index) {
    fixedExtentScrollController.animateToItem(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    metricSelected.value = metrics[0];
    isFirstMetricSelected.addListener(
      () {
        if (isFirstMetricSelected.value) {
          metricSelected.value = metrics[0];
          heightSelected.value =
              convertCmToFt(int.tryParse(heightSelected.value)).toString();
          _scrollToIndex(int.tryParse(heightSelected.value) ?? 1 - 1);
        } else {
          metricSelected.value = metrics[1];
          heightSelected.value =
              convertFtToCm(int.tryParse(heightSelected.value)).toString();
          _scrollToIndex(int.tryParse(heightSelected.value) ?? 1 - 1);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.go(FitFlexClientProfileSelectWeightPage.route);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
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
                              "What is your height?",
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
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
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
                                      controller: fixedExtentScrollController,
                                      selectedValue: heightSelected,
                                      maxCount: metric == metric[0] ? 8 : 245,
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
                          onPressed: () => context
                              .go(FitFlexClientProfileSelectWeightPage.route),
                        )!,
                        PlatformButton().buildButton(
                          backgroundColor: Color(0xFFFFC26A),
                          foregroundColor: Color(0xFFF2F2F7),
                          context: context,
                          type: ButtonType.iconText,
                          icon: Icons.arrow_forward_ios,
                          text: "Continue",
                          onPressed: () {
                            context.read<ClientProfileBloc>().add(
                                  UpdateUserClientProfileEvent(
                                    clientEntity: ClientEntity(
                                      isTrainer: false,
                                      age: int.tryParse(widget.age),
                                      gender: widget.gender,
                                      weight: int.tryParse(widget.weight),
                                      height:
                                          int.tryParse(heightSelected.value),
                                      heightUnit: metricSelected.value,
                                      weightUnit: widget.weightUnit,
                                    ),
                                  ),
                                );
                          },
                        )!
                      ],
                    )
                  ],
                ),
              ),
            ),
            BlocConsumer<ClientProfileBloc, ClientProfileState>(
              builder: (context, state) {
                if (state is ClientProfileLoading) {
                  return FitFlexLoaderWidget(height: height, width: width);
                }
                return SizedBox();
              },
              listener: (context, state) {
                if (state is ClientProfileComplete) {
                  context.go('/profile');
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
