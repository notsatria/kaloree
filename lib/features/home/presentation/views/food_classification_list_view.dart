import 'package:flutter/material.dart';
import 'package:kaloree/features/assesment/presentation/widgets/custom_appbar.dart';

class FoodClassificationListView extends StatelessWidget {
  const FoodClassificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final foodList = [
      'Ayam Goreng',
      'Bakso',
      'Lele Goreng',
      'Nasi Putih',
      'Telur Dadar'
    ];
    return Scaffold(
      appBar: buildCustomAppBar(title: 'List Makanan', context: context),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: foodList.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          title: Text(foodList[index]),
        ),
      ),
    );
  }
}
