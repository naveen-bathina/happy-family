import 'package:flutter/material.dart';
import 'package:fluttertest/providers/data_store.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final DataStore _dataStore = DataStore();
  dynamic _fetchedData;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data from network on init
  }

  // Fetch data from the network
  Future<void> _fetchData() async {
    const String endpoint =
        '${AppConstants.unsecuredApiUrl}/about'; // Replace with your actual API endpoint

    try {
      final data = await _dataStore.fetchDataFromNetwork(endpoint);
      if (data != null) {
        setState(() {
          _fetchedData = data; // Store the fetched data
          _isLoading = false; // Hide the loading indicator
        });
      } else {
        _handleError('No data found');
      }
    } catch (e) {
      _handleError('Failed to load data');
    }
  }

  // Handle error by displaying a message and stopping the loading indicator
  void _handleError(String message) {
    setState(() {
      _isLoading = false; // Hide loading indicator
      _errorMessage = message; // Set error message
    });
  }

  // Common text style for sections
  TextStyle _sectionTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16) ??
        TextStyle(fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About'), centerTitle: true),
      body: OverlayLoaderWithAppIcon(
        isLoading: _isLoading,
        appIcon: Image.asset('assets/images/logo.png'),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the content
          child: ListView(
            children: <Widget>[
              // Logo and Company Name
              Center(
                child: Column(
                  children: [
                    Image.network(
                      _fetchedData?['data']['appLogoUrl'] ?? 'Loading...',
                      height: 80,
                    ),
                    // Image.asset(
                    //   AppConstants.logoPath, // Your logo file path
                    //   height: 80, // Adjust the height as needed
                    // ),
                    const SizedBox(height: 8),
                    Text(
                      _fetchedData?['data']['appTitle'] ??
                          'Loading...', // App title with fallback
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),

              // Display error message if any
              if (_errorMessage.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],

              // Registered Office Address
              const SizedBox(height: 20),
              Text(
                'Registered Office Address:',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _fetchedData?['data']['officeAddress'] ?? 'Loading...',
                style: _sectionTextStyle(context),
              ),

              // Copyrights
              const SizedBox(height: 20),
              Text(
                'Copyrights:',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _fetchedData?['data']['copyRights'] ?? 'Loading...',
                style: _sectionTextStyle(context),
              ),

              // Credits
              const SizedBox(height: 20),
              Text('Credits:', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Text(
                _fetchedData?['data']['credits'] ?? 'Loading...',
                style: _sectionTextStyle(context),
              ),

              // Legal
              const SizedBox(height: 20),
              Text('Legal:', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Text(
                _fetchedData?['data']['legal'] ?? 'Loading...',
                style: _sectionTextStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
