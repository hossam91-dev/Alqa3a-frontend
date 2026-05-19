import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ─── External ───────────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  // ─── Core ────────────────────────────────────────
  sl.registerLazySingleton(() => ApiClient());
}