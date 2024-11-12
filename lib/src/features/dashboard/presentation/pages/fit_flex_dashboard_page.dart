import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexDashboardPage extends StatelessWidget {
  static const String route = "/fit-dashboard";
  const FitFlexDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "Dashboard",
        context: context,
        trailing: PlatformButton().buildButton(
          context: context,
          type: ButtonType.icon,
          icon: Icons.logout,
          text: "",
          onPressed: () => context
              .read<AuthenticationBloc>()
              .add(LogOutAuthenticationEvent()),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Text('//TODO: Dashboard'),
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationLoading) {
                  return FitFlexLoaderWidget(
                    height: height,
                    width: width,
                  );
                }
                return SizedBox();
              },
              listener: (context, state) {
                if (state is AuthenticationComplete) {
                  if (state.entity?.isLoggedIn ?? false) {
                    context.pushReplacement(FitFlexAuthLandingPage.route);
                  } else {
                    context.pushReplacement(FitFlexAuthLandingPage.route);
                  }
                }
                if (state is AuthenticationError) {}
              },
            )
          ],
        ),
      ),
    );
  }
}
