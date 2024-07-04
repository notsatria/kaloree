import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaloree/core/model/food.dart';

Future<void> populateFood() async {
  final firestore = FirebaseFirestore.instance;

  List<Food> foods = [
    Food(
      name: 'Ayam Goreng',
      calories: 391,
      fat: 21.82,
      protein: 32.9,
      carbohydrate: 16.15,
      weight: 150,
    ),
    Food(
      name: 'Bakso',
      calories: 218,
      fat: 14.22,
      protein: 13.4,
      carbohydrate: 8.18,
      weight: 108,
    ),
    Food(
      name: 'Lele Goreng',
      calories: 150,
      fat: 4.08,
      protein: 26.41,
      carbohydrate: 0,
      weight: 142,
    ),
    Food(
      name: 'Nasi Putih',
      calories: 135,
      fat: 0.29,
      protein: 2.79,
      carbohydrate: 29.3,
      weight: 105,
    ),
    Food(
      name: 'Telur Dadar',
      calories: 93,
      fat: 7.33,
      protein: 6.48,
      carbohydrate: 0.42,
      weight: 60,
    ),
  ];

  for (int i = 0; i < foods.length; i++) {
    await firestore.collection('foods').doc(i.toString()).set(foods[i].toMap());
  }
}
