import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modules/bookings/data/datasources/bookings_remote_datasource.dart';
import '../../modules/bookings/data/repositories/bookings_repository_impl.dart';
import '../../modules/bookings/domain/repositories/bookings_repository.dart';
import '../../modules/bookings/presentation/cubit/cubit.dart';
import '../../modules/halls/data/datasources/halls_remote_datasource.dart';
import '../../modules/halls/data/repositories/halls_repository_impl.dart';
import '../../modules/halls/domain/repositories/halls_repository.dart';
import '../../modules/halls/presentation/cubit/cubit.dart';
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

  // ─── Halls ──────────────────────────────────────
  sl.registerLazySingleton(() => HallsRemoteDataSource(sl()));

  sl.registerLazySingleton<HallsRepository>(() => HallsRepositoryImpl(sl()));

  sl.registerFactory(() => HallsCubit(hallsRepository: sl()));

  // ─── Bookings ──────────────────────────────────
  sl.registerLazySingleton(() => BookingsRemoteDataSource(sl()));

  sl.registerLazySingleton<BookingsRepository>(
    () => BookingsRepositoryImpl(sl()),
  );

  sl.registerFactory(() => BookingsCubit(bookingsRepository: sl()));
}
