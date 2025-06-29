import 'package:chat75/core/DB/SupabseService.dart';
import 'package:get_it/get_it.dart';

import '../../featuers/Auth/data/repo/AuthRepo.dart';
import '../../featuers/Auth/presention/cubit/auth_cubit.dart';
import '../DB/dbService.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // db
  getIt.registerSingleton<DbService>(SupabseService());
  // repo
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<DbService>()));
  //cubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt.get<AuthRepo>()));
}
