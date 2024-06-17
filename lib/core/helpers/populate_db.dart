import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaloree/core/model/food.dart';

Future<void> populateFood() async {
  final firestore = FirebaseFirestore.instance;

  List<Food> foods = [
    Food(
      name: 'Ayam Goreng',
      calories: 298,
      fat: 16.8,
      protein: 34.2,
      carbohydrate: 10.76,
      weight: 100,
    ),
    Food(
      name: 'Bakso',
      calories: 202,
      fat: 13.16,
      protein: 12.41,
      carbohydrate: 7.53,
      weight: 100,
    ),
    Food(
      name: 'Gado-gado',
      calories: 132,
      fat: 7.41,
      protein: 7.14,
      carbohydrate: 10.9,
      weight: 100,
    ),
    Food(
      name: 'Nasi Goreng',
      calories: 106,
      fat: 6.23,
      protein: 6.3,
      carbohydrate: 21.06,
      weight: 100,
    ),
    Food(
      name: 'Nasi Putih',
      calories: 129,
      fat: 0.28,
      protein: 2.66,
      carbohydrate: 27.9,
      weight: 100,
    ),
    Food(
      name: 'Soto Ayam',
      calories: 130,
      fat: 6.19,
      protein: 9.96,
      carbohydrate: 8.11,
      weight: 100,
    ),
    Food(
      name: 'Telur Dadar',
      calories: 153,
      fat: 12.02,
      protein: 10.62,
      carbohydrate: 0.69,
      weight: 100,
    ),
    Food(
      name: 'Telur Rebus',
      calories: 154,
      fat: 10.57,
      protein: 12.53,
      carbohydrate: 1.12,
      weight: 100,
    ),
    Food(
      name: 'Tempe Goreng',
      calories: 225,
      fat: 15.21,
      protein: 13.31,
      carbohydrate: 11.94,
      weight: 100,
    ),
  ];

  for (int i = 0; i < foods.length; i++) {
    await firestore.collection('foods').doc(i.toString()).set(foods[i].toMap());
  }
}
