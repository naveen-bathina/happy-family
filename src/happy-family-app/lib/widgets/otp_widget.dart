import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPWidget extends StatefulWidget {
  final ValueChanged<String>
  onOTPComplete; // Callback to pass OTP value to parent

  const OTPWidget({super.key, required this.onOTPComplete});

  @override
  _OTPWidgetState createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers to detect changes
    for (var controller in controllers) {
      controller.addListener(_onOTPChanged);
    }
  }

  @override
  void dispose() {
    // Remove listeners and dispose controllers
    for (var controller in controllers) {
      controller.removeListener(_onOTPChanged);
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOTPChanged() {
    // Combine all OTP digits into a single string
    String otp = controllers.map((controller) => controller.text).join();
    // Check if all 6 digits are entered
    if (otp.length == 6) {
      // Pass the OTP value to the parent widget
      widget.onOTPComplete(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 40,
          height: 50,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace &&
                  controllers[index].text.isEmpty &&
                  index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                controllers[index - 1].clear();
              }
            },
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < 5) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                }
                _onOTPChanged(); // Notify parent of OTP change
              },
            ),
          ),
        );
      }),
    );
  }
}
