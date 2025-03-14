import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/family_info_provider.dart';
import 'package:fluttertest/screens/invite_members_screen.dart'; // Assuming this is your InviteFamilyPage
import 'package:fluttertest/widgets/happy_family_logo_widget.dart';

class JoinFamilyScreen extends ConsumerStatefulWidget {
  const JoinFamilyScreen({super.key});

  @override
  ConsumerState<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends ConsumerState<JoinFamilyScreen> {
  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  // Validate as family code
  String? _validateAsCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a family code';
    }
    if (value.length != 6) {
      return 'Code must be exactly 6 characters';
    }
    if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
      return 'Only letters and numbers are allowed';
    }
    return null;
  }

  // Validate as family name
  String? _validateAsName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a family name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.length > 20) {
      return 'Name cannot exceed 20 characters';
    }
    if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(value)) {
      return 'Only letters and spaces are allowed';
    }
    if (value.trim().isEmpty) {
      return 'Name cannot be just spaces';
    }
    return null;
  }

  void _handleJoinFamily() async {
    if (_formKey.currentState!.validate()) {
      final input = _inputController.text.toUpperCase();
      if (_validateAsCode(input) == null) {
        try {
          // Pass the family code to the provider
          final apiResponse = await ref.read(
            joinFamilyWithCodeProvider(input).future,
          );

          if (apiResponse.success) {
            // Handle successful family join
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(apiResponse.message), // "You joined family"
                backgroundColor: Colors.green,
              ),
            );
          } else {
            // Handle API response with success = false
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(apiResponse.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (error) {
          // Handle errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error joining family: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid 6-character family code'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleCreateFamily() async {
    if (_formKey.currentState!.validate()) {
      final input = _inputController.text.trim();
      if (_validateAsName(input) == null) {
        final apiResponse = await ref.read(
          createFamilyWithNameProvider(input).future,
        );

        if (apiResponse.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Created family with  ${apiResponse.data}',
              ), // "You joined family"
              backgroundColor: Colors.green,
            ),
          );
          _inputController.clear();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (_) => InviteFamilyMembersPage(
                    familyName: input,
                    familyId: apiResponse.data ?? '',
                  ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(apiResponse.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid family name (2-20 characters)'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Family Setup'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HappyFamilyLogo(),
                const SizedBox(height: 20),
                Text(
                  'Join or Create a Family',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter a 6-character code to join\nOR a name to create a family',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _inputController,
                  decoration: InputDecoration(
                    labelText: 'Family Code or Name',
                    hintText: 'e.g., ABC123 or The Smiths',
                    prefixIcon: const Icon(Icons.family_restroom),
                    helperText:
                        'Code: 6 characters (A-Z, 0-9)\nName: 2-20 characters (letters, spaces)',
                  ),
                  maxLength: 20,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a code or name';
                    }
                    // Check if input is a valid code or name
                    if (_validateAsCode(value) != null &&
                        _validateAsName(value) != null) {
                      return 'Please enter a valid family code or name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _handleJoinFamily,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Join Family',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _handleCreateFamily,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Create Family',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
