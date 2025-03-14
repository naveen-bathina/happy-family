import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class PDFViewScreen extends StatelessWidget {
  final String pdfUrl;
  final String title;

  const PDFViewScreen({super.key, required this.pdfUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View $title'),
      ),
      body: FutureBuilder<String>(
        future: _downloadFile(pdfUrl), // Downloads and returns file path
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading PDF'));
          } else if (snapshot.hasData) {
            final filePath = snapshot.data!;
            return PDFView(
              filePath: filePath,
            );
          } else {
            return Center(child: Text('Failed to load PDF.'));
          }
        },
      ),
    );
  }

  Future<String> _downloadFile(String url) async {
    // Request permission to access storage (if necessary)
    if (await Permission.storage.request().isGranted) {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final filePath = '${dir.path}/$fileName';
      final dio = Dio();

      // Download the PDF file
      await dio.download(url, filePath);
      return filePath; // Return file path for PDFView
    } else {
      throw Exception('Storage permission denied');
    }
  }
}