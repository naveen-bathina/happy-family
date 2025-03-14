import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/utils/app_constants.dart';
import 'package:fluttertest/models/family_member_info.dart';
import 'package:fluttertest/providers/data_store_provider.dart';

final memberProvider = FutureProvider<List<FamilyMemberInfo>>((ref) async {
  final dataStore = ref.read(dataStoreProvider);
  final response = await dataStore.fetchDataFromNetwork(
    '${AppConstants.unsecuredApiUrl}${AppConstants.getAllMembersEndpoint}/${AppConstants.familyId}',
  );
  List<FamilyMemberInfo> members = [];
  response['data'].forEach((member) {
    members.add(FamilyMemberInfo.fromJson(member));
  });
  return members;
});
