import 'dart:convert';

import 'package:kaloree/core/model/food.dart';

class ClassificationResult {
  final Food food;
  String? imageUrl;
  final String createdAt;

  ClassificationResult({
    required this.food,
    this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'food': food.toMap(),
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  factory ClassificationResult.fromMap(Map<String, dynamic> map) {
    return ClassificationResult(
      food: Food.fromMap(map['food'] as Map<String, dynamic>),
      imageUrl: map['imageUrl'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassificationResult.fromJson(String source) =>
      ClassificationResult.fromMap(json.decode(source) as Map<String, dynamic>);
}
