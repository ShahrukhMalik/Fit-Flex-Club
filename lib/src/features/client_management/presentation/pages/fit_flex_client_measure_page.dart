import 'package:flutter/material.dart';

class FitFlexClientMeasurePage extends StatelessWidget {
  static const String route = '/fit-flex-client-measure';
  const FitFlexClientMeasurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: double.maxFinite,
        decoration: BoxDecoration(),
        child: Center(
          child: Text(
            'Measure Weight Comming Soon..',
          ),
        ),
      ),
    );
  }
}
