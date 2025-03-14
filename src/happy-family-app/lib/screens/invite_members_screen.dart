import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InviteFamilyMembersPage extends StatefulWidget {
  final String familyId;
  final String familyName;

  const InviteFamilyMembersPage({
    super.key,
    required this.familyId,
    required this.familyName,
  });

  @override
  State<InviteFamilyMembersPage> createState() => _InviteFamilyPageState();
}

class _InviteFamilyPageState extends State<InviteFamilyMembersPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _phoneControllers = [
    TextEditingController(),
  ];
  final List<String> _invitedNumbers = [];

  void _addPhoneField() {
    setState(() {
      _phoneControllers.add(TextEditingController());
    });
  }

  void _removePhoneField(int index) {
    setState(() {
      _phoneControllers.removeAt(index);
    });
  }

  void _submitInvitations() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _invitedNumbers.clear();
        for (var controller in _phoneControllers) {
          _invitedNumbers.add(controller.text);
          controller.clear();
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invitations sent to ${_invitedNumbers.length} members!',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _phoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Invite Family Members'),
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add family members by their phone numbers',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter mobile numbers to send invitations',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: _phoneControllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phoneControllers[index],
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Mobile Number ${index + 1}',
                                  prefixText: '+91 ',
                                  hintText: '1234567890',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  }
                                  if (value.length != 10) {
                                    return 'Please enter a valid 10-digit number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (_phoneControllers.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                color: Colors.red,
                                onPressed: () => _removePhoneField(index),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _addPhoneField,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Another Number'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                    foregroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitInvitations,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Send Invitations',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (_invitedNumbers.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Recently Invited:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8,
                    children:
                        _invitedNumbers
                            .map(
                              (number) => Chip(
                                label: Text('+91 $number'),
                                backgroundColor: Colors.blue.shade50,
                              ),
                            )
                            .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
