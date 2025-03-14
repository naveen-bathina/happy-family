class FamilyMemberInfo {
  final String id;
  final String firstName;
  final String lastName;
  final String role;
  final String gender;
  final String relation;
  final String displayPicture;
  final String contactNumber;
  final String emailAddress;
  final String address;

  FamilyMemberInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.gender,
    required this.relation,
    required this.displayPicture,
    required this.contactNumber,
    required this.emailAddress,
    required this.address,
  });

  factory FamilyMemberInfo.fromJson(Map<String, dynamic> json) {
    return FamilyMemberInfo(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      role: json['role'] ?? '',
      gender: json['gender'] ?? '',
      relation: json['relation'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      displayPicture: json['displayPicture'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
