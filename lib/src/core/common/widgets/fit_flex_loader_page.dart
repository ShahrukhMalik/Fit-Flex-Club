import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_profile_page.dart';
import 'package:flutter/material.dart';

class FitFlexLoaderPage extends StatelessWidget {
  static const route = "/fit-flex-loader-page";
  const FitFlexLoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fit_flex_image.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: WorkoutActionButton(
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
