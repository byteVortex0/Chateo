class PersonalInfoModel {
  int? id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String imageUrl;

  PersonalInfoModel({
    this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      id: json['id'] as int,
      firstName: json['frist_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'frist_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'image_url': imageUrl,
    };
  }
}
