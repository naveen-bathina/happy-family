import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/verify_otp.dart';
import 'package:fluttertest/screens/join_family_screen.dart';
import 'package:fluttertest/screens/join_screen.dart';
import 'package:fluttertest/widgets/happy_family_logo_widget.dart';
import 'package:fluttertest/widgets/otp_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertest/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String otpValue = '';
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void _onOTPComplete(String otp) {
    setState(() {
      otpValue = otp;
    });
    print('Current OTP: $otp');
  }

  void _showOTPBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter OTP",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              OTPWidget(onOTPComplete: _onOTPComplete),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Resend OTP logic here
                  _requestOTP();
                },
                child: const Text("Resend OTP"),
              ),
              ElevatedButton(
                onPressed: () {
                  _verifyOTP();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Verify OTP"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _requestOTP() async {
    if (!mounted) return;

    final isUserLogged = await ref.read(isUserLoggedInProvider.future);
    if (isUserLogged && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const JoinFamilyScreen()),
        (Route route) => false,
      );
      return;
    }

    final phoneNumber = phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    if (!mounted) return;
    ref
        .read(requestOtpProvider(phoneNumber).future)
        .then((success) {
          if (!mounted) return;
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP sent successfully!')),
            );
            _showOTPBottomSheet();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to send OTP.')),
            );
          }
        })
        .catchError((error) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $error')));
        });
  }

  void _verifyOTP() {
    final phoneNumber = phoneController.text.trim();
    if (otpValue.isEmpty || otpValue.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a valid OTP')));
      return;
    }

    final verifyOtp = VerifyOtp(phoneNumber: phoneNumber, otp: otpValue);
    ref
        .read(verifyOtpProvider(verifyOtp).future)
        .then((jwtToken) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP verified successfully!')),
          );
          // Navigate to the home screen after successful verification
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const JoinFamilyScreen()),
            (Route route) => false,
          );
        })
        .catchError((error) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to verify OTP: $error')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HappyFamilyLogo(),
            const SizedBox(height: 20),
            Text(
              "Welcome, Please login here",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Mobile Number",
                prefixIcon: Icon(Icons.phone),
                prefixText: "+91 ",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestOTP,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Send OTP"),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JoinScreen()),
                );
              },
              child: const Text("Not joined yet? Join Here"),
            ),
          ],
        ),
      ),
    );
  }
}
