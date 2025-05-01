import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FitFlexAnnouncementsPage extends StatelessWidget {
  static const route = 'announcements_page';
  const FitFlexAnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "Announcements",
        foregroundColor: globalColorScheme.primary,
        context: context,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        onLeadingPressed: context.pop,
        // trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ),
    );
  }
}
