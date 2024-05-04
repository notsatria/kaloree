import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/home/presentation/views/home_view.dart';
import 'package:kaloree/features/profile/presentation/views/profile_view.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(const BottomNavigationInitial(selectedIndex: 0));

  void changeIndex(int index) {
    emit(BottomNavigationInitial(selectedIndex: index));
  }

  int get selectedIndex => (state as BottomNavigationInitial).selectedIndex;

  final pageList = [
    const HomeView(),
    const Placeholder(),
    const Placeholder(),
    const ProfileView()
  ];

  Widget get currentPage => pageList[selectedIndex];
}
