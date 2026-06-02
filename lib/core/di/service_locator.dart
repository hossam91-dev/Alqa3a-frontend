import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

import '../../shared/auth/data/datasources/auth_remote_datasource.dart';
import '../../shared/auth/data/repositories/auth_repository_impl.dart';
import '../../shared/auth/domain/repositories/auth_repository.dart';

import '../../shared/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ─── External ─────────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // ─── Core ──────────────────────────────────────
  sl.registerLazySingleton(() => ApiClient());

  // ─── Auth ──────────────────────────────────────
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerFactory(() => AuthCubit(authRepository: sl()));
}
