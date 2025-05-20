import 'package:equatable/equatable.dart';

class PersonalInfoModel extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String imageUrl;
  final String? token;

  const PersonalInfoModel({
    this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    this.token,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      id: json['id'] as String,
      firstName: json['frist_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      imageUrl: json['image_url'] as String,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'frist_name': firstName.trim(),
      'last_name': lastName.trim(),
      'phone_number': phoneNumber.trim(),
      'image_url': imageUrl.trim(),
      'token': token?.trim() ?? '',
    };
  }

  @override
  List<Object?> get props => [id, firstName, lastName, phoneNumber, imageUrl];
}
