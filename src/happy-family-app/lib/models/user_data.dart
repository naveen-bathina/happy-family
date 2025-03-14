class UserData {
  final String? id;
  final String? phoneNumber;
  final String? name;
  final String? accessToken;
  final FamilyInfo? familyInfo;

  UserData({
    this.id,
    this.phoneNumber,
    this.name,
    this.accessToken,
    this.familyInfo,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      accessToken: json['accessToken'],
      familyInfo:
          json['familyInfo'] != null
              ? FamilyInfo.fromJson(json['familyInfo'])
              : null,
    );
  }
}

class FamilyInfo {
  final String? familyId;
  final String? familyName;
  final List<FamilyMember>? members;

  FamilyInfo({this.familyId, this.familyName, this.members});

  factory FamilyInfo.fromJson(Map<String, dynamic> json) {
    return FamilyInfo(
      familyId: json['familyId'],
      familyName: json['familyName'],
      members:
          (json['members'] as List<dynamic>?)
              ?.map((member) => FamilyMember.fromJson(member))
              .toList(),
    );
  }
}

class FamilyMember {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? role;

  FamilyMember({this.id, this.name, this.phoneNumber, this.role});

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
    );
  }
}
