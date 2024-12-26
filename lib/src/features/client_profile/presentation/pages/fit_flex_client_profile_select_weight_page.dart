import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_age_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_height_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitFlexClientProfileSelectWeightPage extends StatefulWidget {
  final String gender;
  final String age;
  static const String route = "select-weight";
  const FitFlexClientProfileSelectWeightPage({
    super.key,
    required this.gender,
    required this.age,
  });

  @override
  State<FitFlexClientProfileSelectWeightPage> createState() =>
      _FitFlexClientProfileSelectWeightPageState();
}

class _FitFlexClientProfileSelectWeightPageState
    extends State<FitFlexClientProfileSelectWeightPage> {
  final ValueNotifier<String> weightSelected = ValueNotifier<String>("50");
  final ValueNotifier<String> decimalWeightSelected =
      ValueNotifier<String>("50");
  final ValueNotifier<String> metricSelected = ValueNotifier<String>("");
  final ValueNotifier<bool> isFirstMetricSelected = ValueNotifier<bool>(true);
  final FixedExtentScrollController majorWeightController =
      FixedExtentScrollController(initialItem: 50);
  final FixedExtentScrollController decimalWeightController =
      FixedExtentScrollController(initialItem: 50);

  final List<String> metrics = ['kg', 'lb'];

  void _scrollToIndex(int index, int minorIndex) {
    majorWeightController.animateToItem(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    decimalWeightController.animateToItem(
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
              '${weightSelected.value}.${decimalWeightSelected.value}');
          final getWeightConverted =
              convertLbToKgDouble(currentValue).toStringAsFixed(2);

          weightSelected.value = getWeightConverted.split('.')[0];
          decimalWeightSelected.value = getWeightConverted.split('.')[1];
          _scrollToIndex(int.tryParse(weightSelected.value) ?? 1 - 1,
              int.tryParse(decimalWeightSelected.value) ?? 1 - 1);
        } else {
          metricSelected.value = metrics[1];
          final currentValue = double.tryParse(
              '${weightSelected.value}.${decimalWeightSelected.value}');
          final getWeightConverted =
              convertKgToLbDouble(currentValue).toStringAsFixed(2);

          weightSelected.value = getWeightConverted.split('.')[0];
          decimalWeightSelected.value = getWeightConverted.split('.')[1];
          _scrollToIndex(int.tryParse(weightSelected.value) ?? 1 - 1,
              int.tryParse(decimalWeightSelected.value) ?? 1 - 1);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    isFirstMetricSelected.removeListener(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.go(FitFlexClientProfileSelectAgePage.route);
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
                          "How much do you weigh?",
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
                                  valueListenable: decimalWeightSelected,
                                  builder: (context, decimalWeight, _) {
                                    return ValueListenableBuilder(
                                      valueListenable: weightSelected,
                                      builder: (context, age, _) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 25),
                                          child: Text(
                                            "$age.$decimalWeight" " $metric",
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
                                      selectedValueKgLb: weightSelected,
                                      selectedValueGmsOz: decimalWeightSelected,
                                      controllerKgLb: majorWeightController,
                                      controllerGmsOz: decimalWeightController,
                                      maxCountKgLb: 1499,
                                      maxCountGmsOz: 11,
                                      unitKgLb: showkg ? 'kg' : 'lb',
                                      unitGmsOz: showkg ? 'gm' : 'oz',
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
                      context: context,
                      type: ButtonType.iconText,
                      icon: Icons.arrow_forward_ios,
                      textStyle: TextStyle(
                        color: globalColorScheme.tertiaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "Continue",
                      onPressed: () => context.push(
                        '${FitFlexClientProfileSelectGenderPage.route}/${FitFlexClientProfileSelectAgePage.route}/${FitFlexClientProfileSelectWeightPage.route}/${FitFlexClientProfileSelectHeightPage.route}',
                        extra: {
                          "gender": widget.gender,
                          "age": widget.age,
                          "weight":
                              '${weightSelected.value}.${decimalWeightSelected.value}',
                          "weightUnit":
                              isFirstMetricSelected.value ? 'kg' : 'lb',
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

class FitFlexScrollWheelWidget extends StatefulWidget {
  final ValueNotifier<String> selectedValueKgLb;
  final ValueNotifier<String> selectedValueGmsOz;
  final FixedExtentScrollController controllerKgLb;
  final FixedExtentScrollController controllerGmsOz;
  final int maxCountKgLb;
  final int maxCountGmsOz;
  final String unitKgLb;
  final String unitGmsOz;

  const FitFlexScrollWheelWidget({
    super.key,
    required this.selectedValueKgLb,
    required this.selectedValueGmsOz,
    required this.controllerKgLb,
    required this.controllerGmsOz,
    required this.maxCountKgLb,
    required this.maxCountGmsOz,
    required this.unitKgLb,
    required this.unitGmsOz,
  });

  @override
  State<FitFlexScrollWheelWidget> createState() =>
      _FitFlexScrollWheelWidgetState();
}

class _FitFlexScrollWheelWidgetState extends State<FitFlexScrollWheelWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        widget.selectedValueKgLb.value =
            widget.controllerKgLb.initialItem.toString();
        widget.selectedValueGmsOz.value =
            widget.controllerGmsOz.initialItem.toString();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.controllerKgLb.dispose();
    widget.controllerGmsOz.dispose();
    super.dispose();
  }

  Widget _buildWheelItem({
    required int index,
    required ValueNotifier<String> selectedValue,
    required String unit,
    bool isBold = false,
  }) {
    return ValueListenableBuilder(
      valueListenable: selectedValue,
      builder: (context, selected, _) {
        return Center(
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 20.0,
              color: int.parse(selected) == index ? Colors.black : Colors.grey,
              fontWeight: int.parse(selected) == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }

  Widget _indicator({
    required String unit,
    required double width,
  }) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 40,
        minWidth: 120,
        maxHeight: 40,
        maxWidth: 120,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200]?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text(
            unit,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListWheelScrollView.useDelegate(
                  controller: widget.controllerKgLb,
                  itemExtent: 25.0,
                  diameterRatio: 1.2,
                  perspective: 0.002,
                  onSelectedItemChanged: (index) {
                    widget.selectedValueKgLb.value = (index + 1).toString();
                  },
                  childDelegate: ListWheelChildListDelegate(
                    children: List<Widget>.generate(
                      widget.maxCountKgLb,
                      (index) => _buildWheelItem(
                        index: index + 1,
                        selectedValue: widget.selectedValueKgLb,
                        unit: widget.unitKgLb,
                      ),
                    ),
                  ),
                ),
                _indicator(unit: widget.unitKgLb, width: width),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListWheelScrollView.useDelegate(
                  controller: widget.controllerGmsOz,
                  itemExtent: 25.0,
                  diameterRatio: 1.2,
                  perspective: 0.002,
                  onSelectedItemChanged: (index) {
                    widget.selectedValueGmsOz.value = (index).toString();
                  },
                  childDelegate: ListWheelChildListDelegate(
                    children: List<Widget>.generate(
                      widget.maxCountGmsOz,
                      (index) => _buildWheelItem(
                        index: index,
                        selectedValue: widget.selectedValueGmsOz,
                        unit: widget.unitGmsOz,
                      ),
                    ),
                  ),
                ),
                _indicator(unit: widget.unitGmsOz, width: width),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class FitFlexClientProfileSelectWeightPage extends StatefulWidget {
//   final String gender;
//   final String age;
//   static const String route = "/select-weight";

//   const FitFlexClientProfileSelectWeightPage({
//     super.key,
//     required this.gender,
//     required this.age,
//   });

//   @override
//   State<FitFlexClientProfileSelectWeightPage> createState() =>
//       _FitFlexClientProfileSelectWeightPageState();
// }

// class _FitFlexClientProfileSelectWeightPageState
//     extends State<FitFlexClientProfileSelectWeightPage> {
//   final ValueNotifier<String> selectedValueKgLb = ValueNotifier<String>("50");
//   final ValueNotifier<String> selectedValueGmsOz = ValueNotifier<String>("0");
//   final ValueNotifier<bool> isMetricSelected = ValueNotifier<bool>(true);
//   final FixedExtentScrollController controllerKgLb =
//       FixedExtentScrollController(initialItem: 49);
//   final FixedExtentScrollController controllerGmsOz =
//       FixedExtentScrollController(initialItem: 0);

//   @override
//   void initState() {
//     super.initState();
//     isMetricSelected.addListener(() {
//       if (isMetricSelected.value) {
//         // Metric (kg/gms) selected
//         selectedValueKgLb.value =
//             convertLbToKg(int.parse(selectedValueKgLb.value)).toString();
//         selectedValueGmsOz.value = "0";
//       } else {
//         // Imperial (lb/oz) selected
//         selectedValueKgLb.value =
//             convertKgToLb(int.parse(selectedValueKgLb.value)).toString();
//         selectedValueGmsOz.value = "0";
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controllerKgLb.dispose();
//     controllerGmsOz.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Weight"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "How much do you weigh?",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "This is used for personalized results and plans.",
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 32),
//             ValueListenableBuilder(
//               valueListenable: isMetricSelected,
//               builder: (context, isMetric, child) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ChoiceChip(
//                       label: const Text("kg/gms"),
//                       selected: isMetric,
//                       onSelected: (value) => isMetricSelected.value = value,
//                     ),
//                     const SizedBox(width: 16),
//                     ChoiceChip(
//                       label: const Text("lb/oz"),
//                       selected: !isMetric,
//                       onSelected: (value) => isMetricSelected.value = !value,
//                     ),
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(height: 32),
//             Expanded(
//               child: FitFlexScrollWheelWidget(
//                 selectedValueKgLb: selectedValueKgLb,
//                 selectedValueGmsOz: selectedValueGmsOz,
//                 controllerKgLb: controllerKgLb,
//                 controllerGmsOz: controllerGmsOz,
//                 maxCountKgLb: 150,
//                 maxCountGmsOz: 16,
//                 unitKgLb: isMetricSelected.value ? "kg" : "lb",
//                 unitGmsOz: isMetricSelected.value ? "gms" : "oz",
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => context.pop(),
//                   child: const Text("Previous"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.push(
//                       "/next-page",
//                       extra: {
//                         "gender": widget.gender,
//                         "age": widget.age,
//                         "weight": selectedValueKgLb.value,
//                         "weightUnit": isMetricSelected.value ? "kg" : "lb",
//                       },
//                     );
//                   },
//                   child: const Text("Continue"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String convertLbToKg(int lb) => (lb * 0.453592).toStringAsFixed(1);

//   String convertKgToLb(int kg) => (kg / 0.453592).toStringAsFixed(1);
// }

// class FitFlexScrollWheelWidget extends StatelessWidget {
//   final ValueNotifier<String> selectedValueKgLb;
//   final ValueNotifier<String> selectedValueGmsOz;
//   final FixedExtentScrollController controllerKgLb;
//   final FixedExtentScrollController controllerGmsOz;
//   final int maxCountKgLb;
//   final int maxCountGmsOz;
//   final String unitKgLb;
//   final String unitGmsOz;

//   const FitFlexScrollWheelWidget({
//     super.key,
//     required this.selectedValueKgLb,
//     required this.selectedValueGmsOz,
//     required this.controllerKgLb,
//     required this.controllerGmsOz,
//     required this.maxCountKgLb,
//     required this.maxCountGmsOz,
//     required this.unitKgLb,
//     required this.unitGmsOz,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;

//     return Row(
//       children: [
//         Expanded(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               ListWheelScrollView.useDelegate(
//                 controller: controllerKgLb,
//                 itemExtent: 40,
//                 onSelectedItemChanged: (index) {
//                   selectedValueKgLb.value = (index + 1).toString();
//                 },
//                 childDelegate: ListWheelChildBuilderDelegate(
//                   builder: (context, index) => index != null && index < maxCountKgLb
//                       ? Center(child: Text("${index + 1}"))
//                       : null,
//                 ),
//               ),
//               _buildIndicator(width, unitKgLb),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               ListWheelScrollView.useDelegate(
//                 controller: controllerGmsOz,
//                 itemExtent: 40,
//                 onSelectedItemChanged: (index) {
//                   selectedValueGmsOz.value = (index).toString();
//                 },
//                 childDelegate: ListWheelChildBuilderDelegate(
//                   builder: (context, index) => index != null && index < maxCountGmsOz
//                       ? Center(child: Text("$index"))
//                       : null,
//                 ),
//               ),
//               _buildIndicator(width, unitGmsOz),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildIndicator(double width, String unit) {
//     return Container(
//       width: width * 0.4,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         unit,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
