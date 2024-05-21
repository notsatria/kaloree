// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassificationResult {
  final String uid;
  final String userId;
  final String foodId;
  final String classificationImage;
  final String date;
  final String updatedAt;

  ClassificationResult({
    required this.uid,
    required this.userId,
    required this.foodId,
    required this.classificationImage,
    required this.date,
    required this.updatedAt,
  });

  ClassificationResult copyWith({
    String? uid,
    String? userId,
    String? foodId,
    String? classificationImage,
    String? date,
    String? updatedAt,
  }) {
    return ClassificationResult(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      foodId: foodId ?? this.foodId,
      classificationImage: classificationImage ?? this.classificationImage,
      date: date ?? this.date,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userId': userId,
      'foodId': foodId,
      'classificationImage': classificationImage,
      'date': date,
      'updatedAt': updatedAt,
    };
  }

  factory ClassificationResult.fromMap(Map<String, dynamic> map) {
    return ClassificationResult(
      uid: map['uid'] as String,
      userId: map['userId'] as String,
      foodId: map['foodId'] as String,
      classificationImage: map['classificationImage'] as String,
      date: map['date'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassificationResult.fromJson(String source) =>
      ClassificationResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassificationResult(uid: $uid, userId: $userId, foodId: $foodId, classificationImage: $classificationImage, date: $date, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ClassificationResult other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userId == userId &&
        other.foodId == foodId &&
        other.classificationImage == classificationImage &&
        other.date == date &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userId.hashCode ^
        foodId.hashCode ^
        classificationImage.hashCode ^
        date.hashCode ^
        updatedAt.hashCode;
  }
}
