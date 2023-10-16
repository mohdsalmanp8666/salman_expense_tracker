import 'dart:convert';

class UserModel {
  String uid;
  UserPersonalDetails details;

  UserModel({
    required this.uid,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'details': details.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      details: UserPersonalDetails.fromMap(map['details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

class UserPersonalDetails {
  String name;
  String email;
  String phoneNumber;
  String profilePic;
  String createdAt;
  UserPersonalDetails({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePic,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'createdAt': createdAt,
    };
  }

  factory UserPersonalDetails.fromMap(Map<String, dynamic> map) {
    return UserPersonalDetails(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePic: map['profilePic'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPersonalDetails.fromJson(String source) =>
      UserPersonalDetails.fromMap(json.decode(source));
}
