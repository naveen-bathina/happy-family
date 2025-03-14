import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/jwt_token.dart';
import 'package:fluttertest/models/verify_otp.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Provider for requesting OTP
final requestOtpProvider = FutureProvider.family<bool, String>((
  ref,
  phoneNumber,
) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.postDataToNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.requestOtpEndpoint}',
    {'phoneNumber': phoneNumber},
  );
  return response['data'] as bool;
});

/// Provider for verifying OTP
final verifyOtpProvider = FutureProvider.family<JwtToken, VerifyOtp>((
  ref,
  verifyOtp,
) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.postDataToNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.verifyOtpEndpoint}',
    verifyOtp.toJson(),
  );
  if (response['data'] != null) {
    await dataStore.saveDataLocally('token', response['data']);
  }
  return JwtToken.fromJson(response);
});

/// Provider for logging out
final logoutProvider = FutureProvider<bool>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  await dataStore.saveDataLocally('token', null);
  return true;
});

/// Provider for checking if the user is logged in
final isUserLoggedInProvider = FutureProvider<bool>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final token = await dataStore.getDataLocally('token');

  if (token == null) {
    return false;
  } else {
    if (JwtDecoder.isExpired(token)) {
      await dataStore.deleteDataLocally('token');
      return false;
    }
  }
  return !JwtDecoder.isExpired(token);
});
