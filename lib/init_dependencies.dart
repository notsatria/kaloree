import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kaloree/core/helpers/image_classification_helper.dart';
import 'package:kaloree/features/assesment/data/datasource/assesment_remote_datasource.dart';
import 'package:kaloree/features/assesment/data/repositories/assesment_repository_impl.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';
import 'package:kaloree/features/assesment/domain/usecases/get_user_data.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_save_assesment.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_update_gender.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_update_last_assesment_data.dart';
import 'package:kaloree/features/assesment/presentation/bloc/assesment_bloc.dart';
import 'package:kaloree/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:kaloree/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';
import 'package:kaloree/features/auth/domain/usecases/user_sign_in.dart';
import 'package:kaloree/features/auth/domain/usecases/user_sign_up.dart';
import 'package:kaloree/features/auth/presentaion/bloc/auth_bloc.dart';
import 'package:kaloree/features/catatan/data/datasource/catatan_remote_datasource.dart';
import 'package:kaloree/features/catatan/data/repositories/catatan_repository_impl.dart';
import 'package:kaloree/features/catatan/domain/repositories/catatan_repository.dart';
import 'package:kaloree/features/catatan/domain/usecases/get_catatan_list_by_month_usecase.dart';
import 'package:kaloree/features/catatan/presentation/bloc/catatan_bloc.dart';
import 'package:kaloree/features/home/data/datasource/home_remote_datasource.dart';
import 'package:kaloree/features/home/data/repositories/home_repository_impl.dart';
import 'package:kaloree/features/home/domain/repositories/home_repository.dart';
import 'package:kaloree/features/home/domain/usecases/get_user_data_on_home_usecase.dart';
import 'package:kaloree/features/home/presentation/bloc/user_home_bloc.dart';
import 'package:kaloree/features/scan/data/datasource/image_classification_remote_datasource.dart';
import 'package:kaloree/features/scan/data/repositories/image_classification_repository_impl.dart';
import 'package:kaloree/features/scan/domain/repositories/image_classification_repository.dart';
import 'package:kaloree/features/scan/domain/usecase/get_food_detail_usecase.dart';
import 'package:kaloree/features/scan/domain/usecase/save_classification_result_usecase.dart';
import 'package:kaloree/features/scan/presentation/bloc/image_classification_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final imageClassificationHelper = ImageClassificationHelper();
  imageClassificationHelper.initHelper();

  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
  serviceLocator.registerLazySingleton(() => imageClassificationHelper);
  _initAuth();
  _initAssesment();
  _initImageClassification();
  _initCatatan();
  _initHome();
}

void _initAuth() {
  //  Datasources
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
  );

  // repositories
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  // usecases
  serviceLocator.registerFactory(
    () => UserSignUp(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignIn(serviceLocator()),
  );

  // blocs
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
    ),
  );
}

void _initAssesment() {
  //  Datasources
  serviceLocator.registerFactory<AssesmentRemoteDataSource>(
    () => AssesmentRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
  );

  // repositories
  serviceLocator.registerFactory<AssesmentRepository>(
    () => AssesmentRepositoryImpl(serviceLocator()),
  );

  // usecases
  serviceLocator.registerFactory(
    () => UserSaveAssesment(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserUpdateGender(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserUpdateLastAssesment(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetUserDataUseCase(serviceLocator()),
  );

  // blocs
  serviceLocator.registerLazySingleton(
    () => AssesmentBloc(
        userSaveAssesment: serviceLocator(),
        userUpdateGender: serviceLocator(),
        userUpdateLastAssesment: serviceLocator(),
        getUserDataUseCase: serviceLocator()),
  );
}

void _initImageClassification() {
  // Datasources
  serviceLocator.registerFactory<ImageClassificationRemoteDataSource>(
    () => ImageClassificationRemoteDataSourceImpl(
        serviceLocator(), serviceLocator(), serviceLocator()),
  );

  // Repositories
  serviceLocator.registerFactory<ImageClassificationRepository>(
    () => ImageClassificationRepositoryImpl(serviceLocator()),
  );

  // Usecases
  serviceLocator.registerFactory<GetFoodDetailUseCase>(
    () => GetFoodDetailUseCase(serviceLocator()),
  );

  serviceLocator.registerFactory<SaveClassificationResultUseCase>(
    () => SaveClassificationResultUseCase(serviceLocator()),
  );

  // bloc
  serviceLocator.registerLazySingleton(
    () => ImageClassificationBloc(
      helper: serviceLocator(),
      getFoodDetailUseCase: serviceLocator(),
      saveClassificationResultUseCase: serviceLocator(),
    ),
  );
}

void _initCatatan() {
  // datasource
  serviceLocator.registerFactory<CatatanRemoteDataSource>(
    () => CatatanRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
  );

  // repository
  serviceLocator.registerFactory<CatatanRepository>(
    () => CatatanRepositoryImpl(serviceLocator()),
  );

  // usecases
  serviceLocator.registerFactory<GetCatatanListByMonthUseCase>(
    () => GetCatatanListByMonthUseCase(serviceLocator()),
  );

  // bloc
  serviceLocator.registerLazySingleton<CatatanBloc>(
    () => CatatanBloc(getCatatanListByMonthUseCase: serviceLocator()),
  );
}

void _initHome() {
  // Datasources
  serviceLocator.registerFactory<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
  );

  // Repositories
  serviceLocator.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(serviceLocator()),
  );

  // Usecases
  serviceLocator.registerFactory<GetUserDataOnHomeUseCase>(
    () => GetUserDataOnHomeUseCase(serviceLocator()),
  );

  // Blocs
  serviceLocator.registerLazySingleton<UserHomeBloc>(
    () => UserHomeBloc(getUserDataUseCase: serviceLocator()),
  );
}
