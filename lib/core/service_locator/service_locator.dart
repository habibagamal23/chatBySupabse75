import 'package:chat75/core/DB/SupabseService.dart';
import 'package:chat75/featuers/Home/data/repo/homeRepo.dart';
import 'package:chat75/featuers/Home/presention/messages_cubit.dart';
import 'package:chat75/featuers/Home/presention/room_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../featuers/Auth/data/repo/AuthRepo.dart';
import '../../featuers/Auth/presention/cubit/auth_cubit.dart';
import '../../featuers/contacts/data/repo/contactsRepo.dart';
import '../../featuers/contacts/presention/cubit/contacts_cubit.dart';
import '../../featuers/profile/data/repo/profileRepo.dart';
import '../../featuers/profile/presention/cubit/profile_cubit.dart';
import '../DB/dbService.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // db
  getIt.registerSingleton<DbService>(SupabseService());
  // repo
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<DbService>()));
  getIt.registerSingleton<ContactsRepo>(
      ContactsRepoImpl(getIt.get<DbService>()));
  getIt.registerSingleton<ProfileRepo>(ProfileRepoImpl(getIt<DbService>()));
  getIt.registerSingleton<HomeRepo>(HomeRepo(getIt<DbService>()));
  //cubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt.get<AuthRepo>()));
  getIt.registerFactory<ContactsCubit>(
      () => ContactsCubit(getIt.get<ContactsRepo>()));
  getIt.registerFactory<ProfileCubit>(
      () => ProfileCubit(getIt.get<ProfileRepo>()));
  getIt.registerFactory<RoomCubit>(() => RoomCubit(getIt.get<HomeRepo>()));
  getIt.registerFactory<MessagesCubit>(
      () => MessagesCubit(getIt.get<HomeRepo>()));
}
