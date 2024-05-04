import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/main_menu/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:kaloree/features/main_menu/presentation/widgets/custom_navigation_item.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: const CustomScanNavigationItem(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: context.read<BottomNavigationCubit>().currentPage,
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0f000000),
                    offset: Offset(0, -4),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ]),
            child: Row(
              children: [
                CustomNavigationItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Beranda',
                  currentIndex:
                      context.read<BottomNavigationCubit>().selectedIndex,
                  index: 0,
                  onTap: () {
                    context.read<BottomNavigationCubit>().changeIndex(0);
                  },
                ),
                CustomNavigationItem(
                  icon: Icons.sticky_note_2_outlined,
                  activeIcon: Icons.sticky_note_2,
                  label: 'Catatan',
                  currentIndex:
                      context.read<BottomNavigationCubit>().selectedIndex,
                  index: 1,
                  onTap: () {
                    context.read<BottomNavigationCubit>().changeIndex(1);
                  },
                ),
                const Expanded(child: SizedBox()),
                CustomNavigationItem(
                  icon: Icons.sports_gymnastics_outlined,
                  activeIcon: Icons.sports_gymnastics,
                  label: 'Olahraga',
                  currentIndex:
                      context.read<BottomNavigationCubit>().selectedIndex,
                  index: 2,
                  onTap: () {
                    context.read<BottomNavigationCubit>().changeIndex(2);
                  },
                ),
                CustomNavigationItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profil',
                  currentIndex:
                      context.read<BottomNavigationCubit>().selectedIndex,
                  index: 3,
                  onTap: () {
                    context.read<BottomNavigationCubit>().changeIndex(3);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
