import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/document.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/providers/documents_provider.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:fluttertest/utils/formatters.dart';
import 'pdf_view_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsyncValue = ref.watch(documentsProvider);
    final dataNotifier = ref.read(dataProvider.notifier);
    final dataStore = ref.read(dataStoreProvider);

    // Check if the device is offline
    final isOffline = dataStore.isOfflineMode();

    // Sync data when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataNotifier.syncData(
        '${AppConstants.unsecuredApiUrl}${AppConstants.getAllDocumentsEndpoint}',
        'documentsKey',
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Documents'), centerTitle: true),
      body: SafeArea(
        child:
            isOffline
                ? const Center(
                  child: Text(
                    'You are offline. Displaying cached data.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                : documentsAsyncValue.when(
                  data: (documents) {
                    if (documents.isEmpty) {
                      return const Center(
                        child: Text(
                          'No documents available.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        return _buildDocumentCard(document, context);
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(
                        'Error: $error',
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
      ),
    );
  }

  // Widget to build a document card
  Widget _buildDocumentCard(Document document, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          document.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Updated: ${Formatters.formatDateTime(document.updatedAt)}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Author: ${document.author}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PDFViewScreen(
                          pdfUrl: document.downloadUrl,
                          title: document.title,
                        ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.download, color: Colors.green),
              onPressed: () => _downloadFile(document.downloadUrl, context),
            ),
          ],
        ),
      ),
    );
  }

  // Function to download a file
  Future<void> _downloadFile(String url, BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        final fileName = url.split('/').last;
        final filePath = '${dir.path}/$fileName';
        final dio = Dio();

        await dio.download(url, filePath);
        if (kDebugMode) {
          print('Downloaded file to: $filePath');
        }

        // Check if the widget is still mounted before using the context
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Download complete!')));
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error downloading file: $e');
        }
        // Check if the widget is still mounted before using the context
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Download failed. Please try again.')),
          );
        }
      }
    } else {
      if (kDebugMode) {
        print('Storage permission denied.');
      }
      // Check if the widget is still mounted before using the context
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied.')),
        );
      }
    }
  }
}
