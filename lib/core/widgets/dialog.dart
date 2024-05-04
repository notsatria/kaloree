import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showBackDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Keluar dari Kaloree?'),
        content: const Text(
          'Kamu yakin keluar dari Kaloree?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Tidak'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Keluar'),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
}
