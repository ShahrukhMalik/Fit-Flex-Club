import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/snack_bar.dart';
import 'package:fit_flex_club/src/features/broadcast/domain/entities/notification_entity.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/sendnotification/sendnotification_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_select_clients_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class FitFlexPersonalizedNotificationPage extends StatelessWidget {
  static const route = 'personalized_notification';
  const FitFlexPersonalizedNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColorScheme.surface,
      appBar: PlatformAppbar.basicAppBar(
        automaticallyImplyLeading: true,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        title: "Send Notifications",
        context: context,
      ),
      body: Localizations(
        locale: const Locale('en'),
        delegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: Material(
          child: EnhancedFcmForm(),
        ),
      ),
    );
  }
}

class EnhancedFcmForm extends StatefulWidget {
  const EnhancedFcmForm({super.key});

  @override
  State<EnhancedFcmForm> createState() => _EnhancedFcmFormState();
}

class _EnhancedFcmFormState extends State<EnhancedFcmForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final ValueNotifier<List<ClientEntity?>> selectedClientsNotifier =
      ValueNotifier([]);

  Future<void> _selectClients() async {
    final result = await context.push(
      '${FitFlexTrainerHubPage.route}/${FitFlexPersonalizedNotificationPage.route}/${FitFlexSelectClientsPage.route}',
      extra: {
        'selectedClients': selectedClientsNotifier.value,
      },
    );
    if (result.runtimeType == List<ClientEntity?>) {
      selectedClientsNotifier.value = result as List<ClientEntity?>;
    }
  }

  Future<void> _sendNotification() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedClientsNotifier.value.isEmpty) {
        Fluttertoast.showToast(msg: "You haven't selected a single client!");
      } else {
        await context.read<SendNotificationCubit>().sendNotification(
              NotificationEntity(
                notificationTitle: _titleController.text,
                notificationBody: _bodyController.text,
                selectedClients: selectedClientsNotifier.value,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selected Clients",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: selectedClientsNotifier,
                    builder: (context, selectedClients, _) {
                      final selectedPreview = selectedClients.isNotEmpty
                          ? selectedClients
                              .map(
                                (e) => e?.username,
                              )
                              .join(', ')
                          : "None selected";
                      return Text(
                        selectedPreview,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _selectClients,
                    iconAlignment: IconAlignment.end,
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      color: globalColorScheme.secondary,
                    ),
                    label: const Text("Select Clients"),
                    style: TextButton.styleFrom(
                      foregroundColor: globalColorScheme.secondaryContainer,
                      backgroundColor:
                          globalColorScheme.secondaryContainer.withOpacity(0.1),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Notification Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: const Icon(Icons.title),
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Enter title' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _bodyController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Notification Body',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: const Icon(Icons.message),
                    alignLabelWithHint: true,
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Enter body' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<SendNotificationCubit,
                      SendNotificationState>(
                    listener: (context, state) {
                      if (state is SendNotificationError) {
                        PlatformDialog.showAlertDialog(
                          context: context,
                          title: "Notiication",
                          message:
                              state.failures.message ?? 'Something Went Wrong',
                        );
                      }
                      if (state is SendNotificationComplete) {
                        PlatformDialog.showAlertDialog(
                          context: context,
                          title: "Notiication",
                          message:
                              'Notification is queued succesfully, it should reach the client shortly.',
                          onConfirm: () => context.pop(),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SendNotificationLoading) {
                        return PlatformButton().buildButton(
                          context: context,
                          type: ButtonType.loading,
                          icon: Icons.send_sharp,
                          backgroundColor: globalColorScheme.primary,
                          text: '',
                          onPressed: null,
                        )!;
                      }
                      return PlatformButton().buildButton(
                        context: context,
                        type: ButtonType.primary,
                        icon: Icons.send_sharp,
                        backgroundColor: globalColorScheme.primary,
                        textStyle: TextStyle(
                          color: globalColorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                        text: 'Send Notification',
                        onPressed: _sendNotification,
                      )!;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
