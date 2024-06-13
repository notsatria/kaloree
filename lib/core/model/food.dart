// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Food {
  final String name;
  final double calories;
  final double fat;
  final double protein;
  final double carbohydrate;

  Food({
    required this.name,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbohydrate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'calories': calories,
      'fat': fat,
      'protein': protein,
      'carbohydrate': carbohydrate,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] as String,
      calories: map['calories'] as double,
      fat: map['fat'] as double,
      protein: map['protein'] as double,
      carbohydrate: map['carbohydrate'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) =>
      Food.fromMap(json.decode(source) as Map<String, dynamic>);
}
