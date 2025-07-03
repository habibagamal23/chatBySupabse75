import 'package:chat75/core/DB/Failure.dart';
import 'package:chat75/core/DB/dbService.dart';
import 'package:chat75/featuers/Auth/data/model/UserInfoModel.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<Either<Failure, User?>> register(
      String email, String password, String name, String phone);
  Future<Either<Failure, User?>> login(String email, String password);
}

class AuthRepoImpl implements AuthRepo {
  final DbService dbService;
  AuthRepoImpl(this.dbService);

  @override
  Future<Either<Failure, User?>> login(String email, String password) async {
    try {
      final user = await dbService.sigIn(email, password);
      if (user != null) {
        return Right(user);
      } else {
        return Left(DBFailure("User Not Found"));
      }
    } on AuthException catch (e) {
      return Left(DBFailure(
          " the error is ${e.message} and the status code is ${e.statusCode}"));
    } catch (e) {
      return Left(DBFailure("the error is $e"));
    }
  }

  @override
  Future<Either<Failure, User?>> register(
      String email, String password, String name, String phone) async {
    try {
      final user = await dbService.signUp(email, password);
      if (user != null) {
        // save the user info to  db
        UserInfoModel userInfo = UserInfoModel(
            email: email, UID: user.id, uesr_name: name, phone_num: phone);
        await dbService.insert("userInfo", userInfo.toJson());
        print("user info saved");

        return Right(user);
      } else {
        return Left(DBFailure("User Not Found"));
      }
    } on AuthException catch (e) {
      return Left(DBFailure(
          " the error is ${e.message} and the status code is ${e.statusCode}"));
    } catch (e) {
      return Left(DBFailure("the error is $e"));
    }
  }
}
