// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HealthProfile {
  final String uid;
  final int gender;
  final String dateOfBirth;
  final int? age;
  final int height;
  final int weight;
  final String userId;
  final int activityStatus;
  final int healthPurpose;
  final String updatedAt;
  final double? bmiIndex;
  final double? bmr;

  HealthProfile({
    required this.uid,
    required this.gender,
    required this.dateOfBirth,
    this.age,
    required this.height,
    required this.weight,
    required this.userId,
    required this.activityStatus,
    required this.healthPurpose,
    required this.updatedAt,
    this.bmiIndex,
    this.bmr,
  });

  HealthProfile copyWith({
    String? uid,
    int? gender,
    String? dateOfBirth,
    int? age,
    int? height,
    int? weight,
    String? userId,
    int? dailyCaloriesNeed,
    int? activityStatus,
    int? healthPurpose,
    String? nutritionClassification,
    String? updatedAt,
    double? bmiIndex,
    double? bmr,
  }) {
    return HealthProfile(
      uid: uid ?? this.uid,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      userId: userId ?? this.userId,
      activityStatus: activityStatus ?? this.activityStatus,
      healthPurpose: healthPurpose ?? this.healthPurpose,
      updatedAt: updatedAt ?? this.updatedAt,
      bmiIndex: bmiIndex ?? this.bmiIndex,
      bmr: bmr ?? this.bmr,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'height': height,
      'weight': weight,
      'userId': userId,
      'activityStatus': activityStatus,
      'healthPurpose': healthPurpose,
      'updatedAt': updatedAt,
      'bmiIndex': bmiIndex,
      'bmr': bmr,
    };
  }

  factory HealthProfile.fromMap(Map<String, dynamic> map) {
    return HealthProfile(
      uid: map['uid'] as String,
      gender: map['gender'] as int,
      dateOfBirth: map['dateOfBirth'] as String,
      age: map['age'] as int,
      height: map['height'] as int,
      weight: map['weight'] as int,
      userId: map['userId'] as String,
      activityStatus: map['activityStatus'] as int,
      healthPurpose: map['healthPurpose'] as int,
      updatedAt: map['updatedAt'] as String,
      bmiIndex: map['bmiIndex'] as double,
      bmr: map['bmr'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthProfile.fromJson(String source) =>
      HealthProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HealthProfile(uid: $uid, gender: $gender, dateOfBirth: $dateOfBirth, age: $age, height: $height, weight: $weight, userId: $userId, activityStatus: $activityStatus, healthPurpose: $healthPurpose, updatedAt: $updatedAt, bmiIndex: $bmiIndex, bmr $bmr)';
  }

  @override
  bool operator ==(covariant HealthProfile other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.gender == gender &&
        other.dateOfBirth == dateOfBirth &&
        other.age == age &&
        other.height == height &&
        other.weight == weight &&
        other.userId == userId &&
        other.activityStatus == activityStatus &&
        other.healthPurpose == healthPurpose &&
        other.updatedAt == updatedAt &&
        other.bmiIndex == bmiIndex &&
        other.bmr == bmr;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        gender.hashCode ^
        dateOfBirth.hashCode ^
        age.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        userId.hashCode ^
        activityStatus.hashCode ^
        healthPurpose.hashCode ^
        updatedAt.hashCode ^
        bmiIndex.hashCode ^
        bmr.hashCode;
  }
}
