import 'package:chat75/core/DB/Failure.dart';
import 'package:chat75/core/DB/dbService.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<Either<Failure, User?>> register(String email, String password);
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
  Future<Either<Failure, User?>> register(String email, String password) async {
    try {
      final user = await dbService.signUp(email, password);
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
}
