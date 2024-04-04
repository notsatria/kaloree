part of 'bottom_navigation_cubit.dart';

sealed class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

final class BottomNavigationInitial extends BottomNavigationState {
  final int selectedIndex;

  const BottomNavigationInitial({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}