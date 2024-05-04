import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/platform/assets.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit(super.initialState);

  nextPage(int page) => emit(page);

  final List pages = [
    {
      'title': 'Welcome to Kaloree',
      'description':
          'Hidup sehat menjadi menyenangkan dengan aplikasi Kaloree! atur kalori harian kamu dengan mudah dan jadilah versi terbaikmu!',
      'image': onboardingImage_1,
    },
    {
      'title': 'Aman dan Terpercaya untuk digunakan',
      'description':
          'Hidup sehat menjadi menyenangkan dengan aplikasi Kaloree! atur kalori harian kamu dengan mudah dan jadilah versi terbaikmu!',
      'image': onboardingImage_2,
    },
    {
      'title': 'Dapat Memindai berbagai Jenis Makanan',
      'description':
          'Hidup sehat menjadi menyenangkan dengan aplikasi Kaloree! atur kalori harian kamu dengan mudah dan jadilah versi terbaikmu!',
      'image': onboardingImage_3,
    },
    {
      'title': 'Dapatkan Hasil dan Rekomendasi',
      'description':
          'Hidup sehat menjadi menyenangkan dengan aplikasi Kaloree! atur kalori harian kamu dengan mudah dan jadilah versi terbaikmu!',
      'image': onboardingImage_4,
    },
  ];
}
