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
