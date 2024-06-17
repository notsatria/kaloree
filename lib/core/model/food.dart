// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Food {
  final String name;
  final double calories;
  final double fat;
  final double protein;
  final double carbohydrate;
  final double weight;

  Food({
    required this.name,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbohydrate,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'calories': calories,
      'fat': fat,
      'protein': protein,
      'carbohydrate': carbohydrate,
      'weight': weight,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'] as String,
      calories: double.parse(map['calories'].toString()),
      fat: double.parse(map['fat'].toString()),
      protein: double.parse(map['protein'].toString()),
      carbohydrate: double.parse(map['carbohydrate'].toString()),
      weight: double.parse(map['weight'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) =>
      Food.fromMap(json.decode(source) as Map<String, dynamic>);
}
