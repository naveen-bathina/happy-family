class VerifyOtp {
  final String phoneNumber;
  final String otp;

  VerifyOtp({required this.phoneNumber, required this.otp});

  Map<String, dynamic> toJson() => {'phoneNumber': phoneNumber, 'otp': otp};
}
