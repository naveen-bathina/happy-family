import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/api_response.dart';
import 'package:fluttertest/models/family_info.dart';
import 'package:fluttertest/providers/data_store_provider.dart';
import 'package:fluttertest/utils/app_constants.dart';

final familyInfoProvider = FutureProvider<FamilyInfo>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getFamilyInfoEndpoint}/${AppConstants.familyId}',
  );

  return FamilyInfo.fromJson(response['data']);
});

final joinFamilyWithCodeProvider = FutureProvider.family<
  ApiResponse<FamilyInfo>,
  String
>((ref, familyCode) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.postDataToNetworkWithToken(
    '${AppConstants.unsecuredApiUrl}${AppConstants.joinFamilyWithCodeEndpoint}',
    {'familyCode': familyCode},
  );

  final apiResponse = ApiResponse.fromJson(
    response,
    (data) => FamilyInfo.fromJson(data),
  );

  if (apiResponse.success) {
    dataStore.saveDataLocally(
      AppConstants.familyInfoLocalStorageKey,
      apiResponse.data,
    );
  }

  return apiResponse;
});

final createFamilyWithNameProvider = FutureProvider.family<
  ApiResponse<String>,
  String
>((ref, familyName) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.postDataToNetworkWithToken(
    '${AppConstants.unsecuredApiUrl}${AppConstants.createFamilyWithNameEndpoint}',
    {'familyName': familyName},
  );
  return ApiResponse.fromJson(response, (data) => data);
});
