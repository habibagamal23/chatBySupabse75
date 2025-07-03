import 'package:chat75/core/DB/SupabseService.dart';
import 'package:get_it/get_it.dart';

import '../../featuers/Auth/data/repo/AuthRepo.dart';
import '../../featuers/Auth/presention/cubit/auth_cubit.dart';
import '../../featuers/contacts/data/repo/contactsRepo.dart';
import '../../featuers/contacts/presention/cubit/contacts_cubit.dart';
import '../DB/dbService.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // db
  getIt.registerSingleton<DbService>(SupabseService());
  // repo
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<DbService>()));
  getIt.registerSingleton<ContactsRepo>(
      ContactsRepoImpl(getIt.get<DbService>()));
  //cubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt.get<AuthRepo>()));
  getIt.registerFactory<ContactsCubit>(
      () => ContactsCubit(getIt.get<ContactsRepo>()));
}
