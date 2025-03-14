import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/document.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/utils/app_constants.dart';

final documentsProvider = FutureProvider<List<Document>>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getAllDocumentsEndpoint}',
  );
  List<Document> documents = [];
  response['data'].forEach((document) {
    documents.add(Document.fromJson(document));
  });
  return documents;
});
