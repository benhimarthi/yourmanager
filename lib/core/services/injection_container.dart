import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yourmanager/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:yourmanager/features/authentication/data/repositories/authentication_repository_implement.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:yourmanager/features/authentication/domain/usecases/get_user_informations_from_google.dart';
import 'package:yourmanager/features/authentication/domain/usecases/login.dart';
import 'package:yourmanager/features/authentication/domain/usecases/register_account_informations.dart';
import 'package:yourmanager/features/authentication/domain/usecases/verify_phone_number.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(
      () => AuthenticationCubit(
        login: sl(),
        registerAccountInformations: sl(),
        verifyPhoneNumber: sl(),
        getUserInfosFromGoogle: sl(),
      ),
    )

    //Use cases
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => RegisterAccountInformations(sl()))
    ..registerLazySingleton(() => VerifyPhoneNumber(sl()))
    ..registerLazySingleton(() => GetUserInfosFromGoogle(sl()))

    //Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))

    //Data sources
    ..registerLazySingleton<AuthenticationRemoteDataSrc>(
        () => AuthenticationRemoteDataSrcImpl(sl(), sl(), sl()))

    //External Dependancies
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => GoogleSignIn());
}
