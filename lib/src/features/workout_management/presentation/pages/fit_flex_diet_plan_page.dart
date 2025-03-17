import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class FitFlexDietPlanPage extends StatefulWidget {
  final String dietPlan; // Base64 encoded PDF string
  static const route = 'fit-flex-diet-plan';

  const FitFlexDietPlanPage({super.key, required this.dietPlan});

  @override
  _FitFlexDietPlanPageState createState() => _FitFlexDietPlanPageState();
}

class _FitFlexDietPlanPageState extends State<FitFlexDietPlanPage> {
  final ValueNotifier<String?> _pdfFilePath = ValueNotifier(null);
  int _totalPages = 0;
  int _currentPage = 0;
  late PDFViewController _pdfController;
  bool _isReady = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _loadPdfFromBase64(widget.dietPlan);
  }

  Future<void> _loadPdfFromBase64(String base64String) async {
    try {
      Uint8List bytes = base64Decode(base64String);
      Directory tempDir = await getTemporaryDirectory();
      File tempFile = File("${tempDir.path}/diet_plan.pdf");

      await tempFile.writeAsBytes(bytes, flush: true);
      // setState(() {
      _pdfFilePath.value = tempFile.path;
      // });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load PDF: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = globalColorScheme;
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "Diet Plan",
        context: context,
        backgroundColor: colorScheme.onPrimaryContainer,
        onLeadingPressed: () => context.pop(),
      ),
      body: ValueListenableBuilder(
        valueListenable: _pdfFilePath,
        builder: (context, pdfFilePath, _) {
          if (pdfFilePath == null) {
            return Center(
              child: PlatformLoader().buildLoader(
                type: LoaderType.circular,
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: PDFView(
                    filePath: pdfFilePath,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: true,
                    pageFling: true,
                    onRender: (pages) {
                      setState(() {
                        _totalPages = pages ?? 0;
                        _isReady = true;
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    },
                    onPageChanged: (page, total) {
                      setState(() {
                        _currentPage = page ?? 0;
                        _totalPages = total ?? 0;
                      });
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      setState(() {
                        _pdfController = pdfViewController;
                      });
                    },
                  ),
                ),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        _pdfController.setPage(_currentPage - 1);
                      },
                    ),
                    Text("${_currentPage + 1}/$_totalPages"),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        _pdfController.setPage(_currentPage + 1);
                      },
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
