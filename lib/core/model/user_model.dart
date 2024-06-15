// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/model/health_profile.dart';

class UserModel {
  final String uid;
  final String email;
  final String? fullName;
  final String? profilePicture;
  final bool? isAssesmentComplete;
  final String updatedAt;
  final HealthProfile? healthProfile;

  UserModel({
    required this.uid,
    required this.email,
    this.fullName,
    this.profilePicture,
    this.isAssesmentComplete,
    required this.updatedAt,
    this.healthProfile,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? profilePicture,
    bool? isAssesmentComplete,
    List<ClassificationResult>? classificationResultList,
    String? updatedAt,
    HealthProfile? healthProfile,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profilePicture: profilePicture ?? this.profilePicture,
      isAssesmentComplete: isAssesmentComplete ?? this.isAssesmentComplete,
      updatedAt: updatedAt ?? this.updatedAt,
      healthProfile: healthProfile ?? this.healthProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'profilePicture': profilePicture,
      'isAssesmentComplete': isAssesmentComplete,
      'updatedAt': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      isAssesmentComplete: map['isAssesmentComplete'] != null
          ? map['isAssesmentComplete'] as bool
          : null,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, fullName: $fullName, profilePicture: $profilePicture, isAssesmentComplete: $isAssesmentComplete, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.fullName == fullName &&
        other.profilePicture == profilePicture &&
        other.isAssesmentComplete == isAssesmentComplete &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        fullName.hashCode ^
        profilePicture.hashCode ^
        isAssesmentComplete.hashCode ^
        updatedAt.hashCode;
  }
}
