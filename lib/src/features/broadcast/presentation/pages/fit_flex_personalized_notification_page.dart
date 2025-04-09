import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_select_clients_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  List<String> _selectedClients = [
    'Neha Gupta',
    'EnhancedFcmForm',
    'EnhancedFcmForm',
    'EnhancedFcmForm',
    'EnhancedFcmForm',
    'EnhancedFcmForm',
    'EnhancedFcmForm'
  ]; // dummy data

  Future<void> _selectClients() async {

    final result = context.push(
      '${FitFlexTrainerHubPage.route}/${FitFlexPersonalizedNotificationPage.route}/${FitFlexSelectClientsPage.route}',
    );

  }

  void _sendNotification() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement send
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedPreview = _selectedClients.isNotEmpty
        ? _selectedClients.join(', ')
        : "None selected";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
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
                child: Text(
                  selectedPreview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
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
                      backgroundColor: globalColorScheme.secondaryContainer
                          .withOpacity(0.1)),
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
                child: ElevatedButton.icon(
                  onPressed: _sendNotification,
                  icon: Icon(
                    Icons.send_rounded,
                    color: globalColorScheme.onPrimaryContainer,
                  ),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Send Notification'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
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
