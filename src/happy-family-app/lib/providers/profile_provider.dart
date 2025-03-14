// lib/providers/profile_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:fluttertest/models/family_member_info.dart';
import 'package:fluttertest/providers/data_store_provider.dart';

final profileProvider = FutureProvider<FamilyMemberInfo>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final member = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getMyProfileDetailsEndpoint}/${AppConstants.familyId}/${AppConstants.memberId}',
  );
  return FamilyMemberInfo.fromJson(member['data']);
});
