import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:kaloree/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:kaloree/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';
import 'package:kaloree/features/auth/domain/usecases/user_sign_in.dart';
import 'package:kaloree/features/auth/domain/usecases/user_sign_up.dart';
import 'package:kaloree/features/auth/presentaion/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
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
