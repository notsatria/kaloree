import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:kaloree/features/assesment/data/datasource/assesment_remote_datasource.dart';
import 'package:kaloree/features/assesment/data/repositories/assesment_repository_impl.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';
import 'package:kaloree/features/assesment/domain/usecases/get_user_data.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_get_health_profile.dart';
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

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  _initAuth();
  _initAssesment();
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
    () => UserGetHealthProfile(serviceLocator()),
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
      userGetHealthProfile: serviceLocator(),
      getUserDataUseCase: serviceLocator()
    ),
  );
}
