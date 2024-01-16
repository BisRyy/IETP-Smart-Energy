import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/core/network/info.dart';
import 'package:smart_home/feature/smart_home/data/data_source/local/user.dart';
import 'package:smart_home/feature/smart_home/data/data_source/remote/power.dart';
import 'package:smart_home/feature/smart_home/data/data_source/remote/user.dart';
import 'package:smart_home/feature/smart_home/data/repositories/power.dart';
import 'package:smart_home/feature/smart_home/data/repositories/user.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/power.dart';
import 'package:smart_home/feature/smart_home/domain/repositories/user.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/power/view_power.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/power/view_pump.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/user/create.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/user/login.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/user/logout.dart';
import 'package:smart_home/feature/smart_home/domain/use_cases/user/view.dart';
import 'package:smart_home/feature/smart_home/presentation/bloc/power/power_bloc.dart';
import 'package:smart_home/feature/smart_home/presentation/bloc/user/user_bloc.dart';

import 'feature/smart_home/domain/use_cases/power/set_pump.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  // - User
  sl.registerFactory(() => UserBloc(
        userCreate: sl(),
        userLogin: sl(),
        userGet: sl(),
        userLogout: sl(),
      ));

  sl.registerFactory(
    () => PowerBloc(
      viewPower: sl(),
      viewPump: sl(),
      setPump: sl(),
    ),
  );
  // Use cases
  // - User
  sl.registerLazySingleton(() => UserLogin(sl()));
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => LogOut(sl()));

  sl.registerLazySingleton(() => ViewPower(sl()));
  sl.registerLazySingleton(() => ViewPump(sl()));
  sl.registerLazySingleton(() => SetPump(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  sl.registerLazySingleton<PowerRepository>(
    () => PowerRepositoryImp(
      powerRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources - Remote

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<PowerRemoteDataSource>(
    () => PowerRemoteDataSourceImpl(client: sl()),
  );

  // Data sources - Local
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
