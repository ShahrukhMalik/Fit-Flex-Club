import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_height_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitFlexClientProfileSelectWeightPage extends StatefulWidget {
  final String gender;
  final String age;
  static const String route = "/select-weight";
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
  final ValueNotifier<String> weightSelected = ValueNotifier<String>("");
  final ValueNotifier<String> metricSelected = ValueNotifier<String>("");
  final ValueNotifier<bool> isFirstMetricSelected = ValueNotifier<bool>(true);

  final List<String> metrics = ['kg', 'lb'];

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
  void dispose() {
    super.dispose();
    isFirstMetricSelected.removeListener(() {
      
    },);
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
                              valueListenable: weightSelected,
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
                                selectedValue: weightSelected,
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
                    onPressed: () => context.go(
                      FitFlexClientProfileSelectHeightPage.route,
                      extra: {
                        "gender": widget.gender,
                        "age": widget.age,
                        "weight": weightSelected.value,
                        "weightUnit": metricSelected.value,
                      },
                    ),
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

class FitFlexScrollWheelWidget extends StatefulWidget {
  final ValueNotifier<String> selectedValue;
  final int maxCount;
  final String? metric;
  const FitFlexScrollWheelWidget({
    super.key,
    required this.selectedValue,
    this.metric,
    required this.maxCount,
  });

  @override
  State<FitFlexScrollWheelWidget> createState() =>
      _FitFlexScrollWheelWidgetState();
}

class _FitFlexScrollWheelWidgetState extends State<FitFlexScrollWheelWidget> {
  final _controller = FixedExtentScrollController(initialItem: 50);

  @override
  void initState() {
    widget.selectedValue.value = _controller.initialItem.toString();
    super.initState();
  }

  Widget _buildAgeView({
    required int index,
    required ValueNotifier<String> selectedValue,
    String? metric,
  }) {
    return ValueListenableBuilder(
      valueListenable: selectedValue,
      builder: (context, selectedAge, _) {
        return Center(
          child: Text(
            '$index' ' ${metric ?? ''}',
            style: TextStyle(
              fontSize: 20.0,
              color:
                  int.parse(selectedAge) == index ? Colors.black : Colors.grey,
              fontWeight: int.parse(selectedAge) == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }

  Widget _indicator({
    required int currentAge,
    required FixedExtentScrollController controller,
    required double screenWidth,
  }) {
    return IgnorePointer(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 40,
          minWidth: screenWidth * 0.8,
          maxHeight: 40,
          maxWidth: screenWidth * 0.8,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200]?.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width - 32,
            child: ListWheelScrollView.useDelegate(
              controller: _controller,
              itemExtent: 25.0,
              diameterRatio: 1,
              perspective: 0.002,
              onSelectedItemChanged: (index) {
                widget.selectedValue.value = (index + 1).toString();
              },
              childDelegate: ListWheelChildListDelegate(
                children: List<Widget>.generate(
                  widget.maxCount,
                  (index) => _buildAgeView(
                    index: index + 1,
                    selectedValue: widget.selectedValue,
                    metric: widget.metric,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _indicator(
              currentAge: int.tryParse(widget.selectedValue.value) ??
                  _controller.initialItem,
              controller: _controller,
              screenWidth: width,
            ),
          ),
        ),
      ],
    );
  }
}
