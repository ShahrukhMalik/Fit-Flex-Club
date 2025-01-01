import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
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
  static const String route = "select-height";
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
  final ValueNotifier<String> heightSelected = ValueNotifier<String>("5");
  final ValueNotifier<String> decimalheightSelected =
      ValueNotifier<String>("6");
  final ValueNotifier<String> metricSelected = ValueNotifier<String>("ft");
  final ValueNotifier<bool> isFirstMetricSelected = ValueNotifier<bool>(true);
  final FixedExtentScrollController heightController =
      FixedExtentScrollController(initialItem: 5);
  final FixedExtentScrollController decimalHeightController =
      FixedExtentScrollController(initialItem: 0);
  final List<String> metrics = ['ft', 'cm'];

  void _scrollToIndex(int index, int minorIndex) {
    heightController.animateToItem(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    decimalHeightController.animateToItem(
      minorIndex,
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
          final currentValue = double.tryParse(
              '${heightSelected.value}.${decimalheightSelected.value}');
          final getWeightConverted =
              convertCmToFtD(currentValue).toStringAsFixed(2);

          heightSelected.value = getWeightConverted.split('.')[0];
          decimalheightSelected.value = getWeightConverted.split('.')[1];
          _scrollToIndex(int.tryParse(heightSelected.value) ?? 1 - 1,
              int.tryParse(decimalheightSelected.value) ?? 1 - 1);
        } else {
          metricSelected.value = metrics[1];
          final currentValue = double.tryParse(
              '${heightSelected.value}.${decimalheightSelected.value}');
          final getWeightConverted =
              convertFtToCmD(currentValue).toStringAsFixed(2);

          heightSelected.value = getWeightConverted.split('.')[0];
          decimalheightSelected.value = getWeightConverted.split('.')[1];
          _scrollToIndex(int.tryParse(heightSelected.value) ?? 1 - 1,
              int.tryParse(decimalheightSelected.value) ?? 1 - 1);
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
                                      valueListenable: decimalheightSelected,
                                      builder: (context, decimalHeight, _) {
                                        return ValueListenableBuilder(
                                          valueListenable: heightSelected,
                                          builder: (context, age, _) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
                                              child: Text(
                                                "$age.$decimalHeight"
                                                " $metric",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                  SizedBox(
                                    height: height * .4,
                                    child: ValueListenableBuilder(
                                      valueListenable: isFirstMetricSelected,
                                      builder: (context, showkg, _) {
                                        return FitFlexScrollWheelWidget(
                                          selectedValueKgLb: heightSelected,
                                          selectedValueGmsOz:
                                              decimalheightSelected,
                                          controllerKgLb: heightController,
                                          controllerGmsOz:
                                              decimalHeightController,
                                          maxCountKgLb: 1499,
                                          maxCountGmsOz: 12,
                                          unitKgLb: showkg ? 'ft' : 'cm',
                                          unitGmsOz: showkg ? 'in' : 'mm',
                                        );
                                      },
                                    ),
                                  )
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
                          foregroundColor: globalColorScheme.tertiaryContainer,
                          backgroundColor: Colors.transparent,
                          textStyle: TextStyle(
                            color: globalColorScheme.tertiaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                          context: context,
                          type: ButtonType.iconText,
                          icon: Icons.arrow_back_ios_new,
                          iconAlignment: IconAlignment.start,
                          text: "Previous",
                          onPressed: () => context.pop(),
                        )!,
                        PlatformButton().buildButton(
                          backgroundColor: Color(0xFFFFC26A),
                          foregroundColor: globalColorScheme.tertiaryContainer,
                          textStyle: TextStyle(
                            color: globalColorScheme.tertiaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
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
                                      weightInKg:
                                          widget.weightUnit.toLowerCase() ==
                                                  'kg'
                                              ? double.tryParse(widget.weight)
                                              : convertLbToKgDouble(
                                                  double.tryParse(
                                                    widget.weight,
                                                  ),
                                                ),
                                      heightInCm: metricSelected.value
                                                  .toLowerCase() ==
                                              'cm'
                                          ? double.tryParse(
                                              '${heightSelected.value}.${decimalheightSelected.value}')
                                          : convertFtToCmD(
                                              double.tryParse(
                                                '${heightSelected.value}.${decimalheightSelected.value}',
                                              ),
                                            ),
                                      weightInLb: widget.weightUnit
                                                  .toLowerCase() ==
                                              'lb'
                                          ? double.tryParse(widget.weight)
                                          : convertKgToLbDouble(
                                              double.tryParse(widget.weight)),
                                      heightInFt: metricSelected.value
                                                  .toLowerCase() ==
                                              'ft'
                                          ? double.tryParse(
                                              '${heightSelected.value}.${decimalheightSelected.value}')
                                          : convertCmToFtD(
                                              double.tryParse(
                                                '${heightSelected.value}.${decimalheightSelected.value}',
                                              ),
                                            ),
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
                  context.read<AuthenticationBloc>().add(ListenToEvents());
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
