import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataStore {
  static final DataStore _instance = DataStore._internal();
  late Dio _dio;
  Box? _dataBox; // Make _dataBox nullable

  // Private constructor for singleton pattern
  DataStore._internal() {
    _initializeDio();
    _initializeDataBox();
  }

  // Factory constructor to return the singleton instance
  factory DataStore() => _instance;

  // Initialize Dio with SSL certificate handling
  Future<void> _initializeDio() async {
    _dio = Dio();
  }

  // Initialize Hive Box for offline storage
  Future<void> _initializeDataBox() async {
    try {
      await Hive.initFlutter();
      _dataBox = await Hive.openBox('happyFamilyStore'); // Initialize _dataBox
    } catch (e) {
      throw Exception('Failed to initialize Hive box: $e');
    }
  }

  Future<void> initialize() async {
    await _initializeDataBox(); // Call the private method
  }

  // Check if data is available locally (offline mode)
  bool isOfflineMode() {
    if (_dataBox == null) {
      throw Exception('Hive box is not initialized.');
    }
    return _dataBox!.isEmpty;
  }

  // Save data locally
  Future<void> saveDataLocally(String key, dynamic value) async {
    if (_dataBox == null) {
      await _initializeDataBox();
    }
    await _dataBox!.put(key, jsonEncode(value));
  }

  // Retrieve data from local storage
  Future<dynamic> getDataLocally(String key) async {
    if (_dataBox == null) {
      throw Exception('Hive box is not initialized.');
    }
    final data = _dataBox!.get(key);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  // Delete data from local storage
  Future<void> deleteDataLocally(String key) async {
    if (_dataBox == null) {
      throw Exception('Hive box is not initialized.');
    }
    await _dataBox!.delete(key);
  }

  // Save token securely
  Future<void> saveToken(String token) async {
    await saveDataLocally('token', token);
  }

  // Retrieve token
  Future<String?> getToken() async {
    return await getDataLocally('token');
  }

  // Fetch data from the network (online mode)
  Future<dynamic> fetchDataFromNetwork(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch data from network: $e');
    }
  }

  // Fetch data from the network with token (online mode)
  Future<dynamic> fetchDataFromNetworkWithToken(String endpoint) async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('Token not found');

      final response = await _dio.get(
        endpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch data with token: $e');
    }
  }

  // Post data to the network (online mode)
  Future<dynamic> postDataToNetwork(String endpoint, dynamic body) async {
    try {
      final response = await _dio.post(endpoint, data: body);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to post data to network: $e');
    }
  }

  // Post data to the network with token (online mode)
  Future<dynamic> postDataToNetworkWithToken(
    String endpoint,
    dynamic body,
  ) async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('Token not found');

      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to post data with token: $e');
    }
  }

  // Sync data between local storage and network
  Future<void> syncDataWithNetwork(
    String endpoint,
    String localStorageKey,
  ) async {
    if (_dataBox == null) {
      await _initializeDataBox();
    }
    final localData = await getDataLocally(localStorageKey);
    if (localData != null) {
      // Sync logic (if required, you can push local changes to the server here)
      final networkData = await fetchDataFromNetwork(endpoint);
      if (networkData != null) {
        // Store network data locally
        await saveDataLocally(localStorageKey, networkData);
      }
    }
  }

  // Helper method to handle Dio responses
  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed with status code: ${response.statusCode}');
    }
  }
}
