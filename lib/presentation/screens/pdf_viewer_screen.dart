import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {

  const PdfViewerScreen({super.key});

  static const String name = "pdfviewer-screen";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasArrowBack: true,
      body: SfPdfViewer.asset(
        "lib/config/assets/REGIMEN_INTERNO.pdf" 
      ),
    );
  }
}