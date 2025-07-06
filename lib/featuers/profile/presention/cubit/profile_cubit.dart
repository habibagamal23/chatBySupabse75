import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/DB/Failure.dart';
import '../../../Auth/data/model/UserInfoModel.dart';
import '../../data/repo/profileRepo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;
  ProfileCubit(this._repo) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final Either<Failure, UserInfoModel> res = await _repo.getProfileData();
    res.fold(
      (f) => emit(ProfileError(f.message)),
      (u) => emit(ProfileLoaded(u)),
    );
  }

  upadteData(String name, String phone) async {
    emit(ProfileUpdating());
    final result = await _repo.UpdateProfileData(name, phone);
    result.fold(
      (f) => emit(ProfileError(f.message)),
      (u) async {
        emit(ProfileUpdated(u));
        await fetchProfile();
      },
    );
  }

  uploadImage (File avatarFile )async{
    final supbase = Supabase.instance.client;
    final String userId = supbase.auth.currentUser!.id;
    final String fullPath = await supbase.storage.from('images').upload(
      'userProfile/$userId',
      avatarFile,
      fileOptions: const FileOptions(upsert: true),
    );
    // get url of image
    final String publicUrl = await supbase
        .storage
        .from('images')
        .getPublicUrl('userProfile/$userId');

    print(publicUrl);

  }
}
