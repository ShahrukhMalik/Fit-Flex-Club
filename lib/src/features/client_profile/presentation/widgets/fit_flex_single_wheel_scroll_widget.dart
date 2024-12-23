import 'package:flutter/material.dart';

class FitFlexSingleWheelScrollWidget extends StatefulWidget {
  final ValueNotifier<String> selectedValue;
  final FixedExtentScrollController controller;
  final int maxCount;
  final String? metric;
  const FitFlexSingleWheelScrollWidget({
    super.key,
    required this.selectedValue,
    this.metric,
    required this.maxCount,
    required this.controller,
  });

  @override
  State<FitFlexSingleWheelScrollWidget> createState() =>
      _FitFlexSingleWheelScrollWidgetState();
}

class _FitFlexSingleWheelScrollWidgetState
    extends State<FitFlexSingleWheelScrollWidget> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    _controller = widget.controller;
    widget.selectedValue.value = _controller.initialItem.toString();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _scrollToIndex(int index) {
  //   _controller.animateToItem(
  //     index,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }

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
              squeeze: 1.2,
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
