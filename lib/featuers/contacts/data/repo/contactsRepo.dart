import 'package:chat75/core/DB/SupabseService.dart';
import 'package:chat75/featuers/Auth/data/model/UserInfoModel.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/DB/Failure.dart';
import '../../../../core/DB/dbService.dart';

abstract class ContactsRepo {
  Future<Either<Failure, List<UserInfoModel>>> getAllContacts();
}

class ContactsRepoImpl implements ContactsRepo {
  DbService dbService;
  ContactsRepoImpl(this.dbService);

  @override
  Future<Either<Failure, List<UserInfoModel>>> getAllContacts() async {
    try {
      final userid = SupabseService().client.auth.currentUser!.id;
      final rows =
          await dbService.fetchAllDatabyFilterNeq("userInfo", "UID", userid);
      final users = rows.map((e) => UserInfoModel.fromJson(e)).toList();
      print("users ${users.length}");
      return Right(users);
    } catch (e) {
      return Left(DBFailure("the error is $e"));
    }
  }
}
