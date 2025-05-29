// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_announcements_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_personalized_notification_page.dart';
import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_one_to_one_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';

class FitFlexTrainerHubPage extends StatelessWidget {
  static const route = '/trainer_hub';
  const FitFlexTrainerHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColorScheme.surface,
      // appBar: PlatformAppbar.basicAppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: globalColorScheme.onPrimaryContainer,
      //   title: "Trainer Hub",
      //   context: context,
      // ),
      body: FeaturesPage(),
    );
  }
}

// class Feature {
//   final String title;
//   final String description;
//   final IconData icon;
//   final bool isPremium;
//   final String comingSoon;

//   const Feature({
//     required this.title,
//     required this.description,
//     required this.icon,
//     this.isPremium = false,
//     this.comingSoon = '',
//   });
// }

// class FeaturesPage extends StatelessWidget {
//   const FeaturesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<Feature> features = [
//       const Feature(
//         title: 'Personalized Notifications',
//         description:
//             'Send targeted reminders, workout updates, and progress reports directly to your clients. Customize content and scheduling for each individual to boost engagement and results.',
//         icon: Icons.notifications_active,
//         isPremium: true,
//       ),
//       const Feature(
//         title: 'Announcements',
//         description:
//             'Broadcast important updates, promotions, or class changes to all your clients at once. Keep everyone informed about new programs, schedule changes, or special events.',
//         icon: Icons.campaign,
//         isPremium: false,
//       ),
//       const Feature(
//         title: 'One-to-One Chat',
//         description:
//             'Build stronger relationships with your clients through private messaging. Provide personalized guidance, answer questions, and offer real-time support whenever needed.',
//         icon: Icons.chat_bubble,
//         isPremium: true,
//       ),
//     ];

//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.blueAccent,
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Stay connected with your clients through multiple channels',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: features.length,
//               itemBuilder: (context, index) {
//                 final feature = features[index];
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 16),
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: feature.isPremium
//                                     ? Colors.amber.withOpacity(0.2)
//                                     : Colors.blue.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Icon(
//                                 feature.icon,
//                                 size: 28,
//                                 color: feature.isPremium
//                                     ? Colors.amber
//                                     : Colors.blue,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           feature.title,
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       if (feature.isPremium)
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8, vertical: 4),
//                                           decoration: BoxDecoration(
//                                             color: Colors.amber,
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                           ),
//                                           child: const Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Icon(Icons.star,
//                                                   size: 12,
//                                                   color: Colors.white),
//                                               SizedBox(width: 4),
//                                               Text(
//                                                 'Premium',
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       if (feature.comingSoon.isNotEmpty)
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8, vertical: 4),
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey,
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                           ),
//                                           child: Text(
//                                             feature.comingSoon,
//                                             style: const TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     feature.description,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         feature.isPremium
//                             ? ElevatedButton(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.amber,
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Text('Explore Feature'),
//                               )
//                             : OutlinedButton(
//                                 onPressed: () {},
//                                 style: OutlinedButton.styleFrom(
//                                   foregroundColor: Colors.blue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Text('Explore Feature'),
//                               ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: Colors.grey[100],
//             child: Column(
//               children: [
//                 const Text(
//                   'Want to unlock all premium features?',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   icon: const Icon(Icons.star),
//                   label: const Text('Upgrade to Premium'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Feature {
  final String title;
  final String description;
  final IconData icon;
  final bool isPremium;
  final String comingSoon;
  final String route;

  const Feature({
    required this.title,
    required this.description,
    required this.icon,
    required this.isPremium,
    this.comingSoon = '',
    required this.route,
  });
}

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Feature> features = [
      const Feature(
        title: 'Personalized Notifications',
        description:
            'Send personalized reminders, workout updates, and progress reports to each client. Customize content and timing to boost engagement and results.',
        icon: Icons.notifications_active,
        isPremium: true,
        route:
            '${FitFlexTrainerHubPage.route}/${FitFlexPersonalizedNotificationPage.route}',
      ),
      const Feature(
        title: 'One-to-One Chat',
        description:
            'Strengthen client relationships with private messaging. Offer personalized guidance, answer questions, and provide real-time support.',
        icon: Icons.chat_bubble,
        isPremium: true,
        route:
            '${FitFlexTrainerHubPage.route}/${FitFlexOneToOneChatPage.route}',
      ),
      const Feature(
        title: 'Announcements',
        description:
            'Broadcast important updates, promotions, or special events to all your clients at once. Keep everyone informed about new programs and offerings.',
        icon: Icons.campaign,
        isPremium: true,
        route:
            '${FitFlexTrainerHubPage.route}/${FitFlexAnnouncementsPage.route}',
      ),
    ];
    return Scaffold(
      body: Localizations(
        locale: const Locale('en'),
        delegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: Material(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: globalColorScheme.onPrimaryContainer,
                expandedHeight: 150,
                pinned: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // Access FlexibleSpaceBarSettings to get min/max extents
                    final settings = context.dependOnInheritedWidgetOfExactType<
                        FlexibleSpaceBarSettings>();
                    final isCollapsed = settings != null &&
                        constraints.maxHeight <= settings.minExtent + 20;

                    return FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      centerTitle: true,
                      title: isCollapsed
                          ? Text(
                              'Trainer Hub',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: globalColorScheme.primary,
                                fontSize: 22,
                              ),
                            )
                          : null,
                      background: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Hello Trainer',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: globalColorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('EEEE, MMMM d, y')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 16,
                                color: globalColorScheme.onSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Stay connected with your clients through multiple channels',
                              style: TextStyle(
                                fontSize: 14,
                                color: globalColorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 100,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final feature = features[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: feature.isPremium
                                            ? Colors.amber.withOpacity(0.2)
                                            : Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        feature.icon,
                                        size: 28,
                                        color: feature.isPremium
                                            ? Colors.amber
                                            : Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  feature.title,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              if (feature.isPremium)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.star,
                                                          size: 12,
                                                          color: Colors.white),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        'Premium',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (feature.comingSoon.isNotEmpty)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Text(
                                                    feature.comingSoon,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            feature.description,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                feature.isPremium
                                    ? ElevatedButton(
                                        onPressed: () async => context.go(
                                          feature.route,
                                          extra: {
                                            'currentUserId':
                                                getIt<FirebaseAuth>()
                                                    .currentUser
                                                    ?.uid
                                          },
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text('Explore Feature'),
                                      )
                                    : OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text('Explore Feature'),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: features.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
