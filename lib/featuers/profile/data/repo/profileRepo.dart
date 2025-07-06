import 'dart:io';

import 'package:chat75/featuers/Auth/data/model/UserInfoModel.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/DB/Failure.dart';
import '../../../../core/DB/SupabseService.dart';
import '../../../../core/DB/dbService.dart';
import '../../../../core/service_locator/service_locator.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserInfoModel>> getProfileData();
  Future<Either<Failure, String>> UpdateProfileData(String name, String phone);
}

class ProfileRepoImpl implements ProfileRepo {
  DbService dbService;

  ProfileRepoImpl(this.dbService);

  @override
  Future<Either<Failure, UserInfoModel>> getProfileData() async {
    try {
      final userid = dbService.client.auth.currentUser!.id;
      final row = await dbService.getSingleData("userInfo", "UID", userid);
      final user = UserInfoModel.fromJson(row);
      print("users ${user.UID}");
      return Right(user);
    } catch (e) {
      return Left(DBFailure("the error is $e"));
    }
  }

  @override
  Future<Either<Failure, String>> UpdateProfileData(
      String name, String phone) async {
    try {
      final userid = dbService.client.auth.currentUser!.id;
      await dbService.upadte(
          "userInfo", {"uesr_name": name, "phone_num": phone}, "UID", userid);
      return Right("success updated");
    } catch (e) {
      return Left(DBFailure("the error is $e"));
    }
  }
}
