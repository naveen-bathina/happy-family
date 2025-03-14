import 'package:fluttertest/models/family_member_info.dart';

class FamilyInfo {
  final String id;
  final String code;
  final String familyName;
  final String logoUrl;
  final String groupPhotoUrl;
  final int familyMembersCount;
  final List<FamilyMemberInfo> familyMembers;

  FamilyInfo({
    required this.id,
    required this.code,
    required this.familyName,
    required this.logoUrl,
    required this.groupPhotoUrl,
    required this.familyMembersCount,
    required this.familyMembers,
  });

  factory FamilyInfo.fromJson(Map<String, dynamic> json) {
    return FamilyInfo(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      familyName: json['familyName'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      groupPhotoUrl: json['groupPhotoUrl'] ?? '',
      familyMembersCount: json['familyMembersCount'] ?? 0,
      familyMembers:
          (json['members'] as List<dynamic>?)
              ?.map((memberJson) => FamilyMemberInfo.fromJson(memberJson))
              .toList() ??
          [],
    );
  }
}
