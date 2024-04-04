import 'package:flutter/material.dart';
import 'package:kaloree/features/main_menu/presentation/widgets/custom_navigation_item.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomScanNavigationItem(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x0f000000),
                offset: Offset(0, -4),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ]),
        child: const Row(
          children: [
            CustomNavigationItem(
              isActive: true,
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Beranda',
            ),
            CustomNavigationItem(
              isActive: false,
              icon: Icons.sticky_note_2_outlined,
              activeIcon: Icons.sticky_note_2,
              label: 'Catatan',
            ),
            Expanded(child: SizedBox()),
            CustomNavigationItem(
              isActive: false,
              icon: Icons.sports_gymnastics_outlined,
              activeIcon: Icons.sports_gymnastics,
              label: 'Olahraga',
            ),
            CustomNavigationItem(
              isActive: false,
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
