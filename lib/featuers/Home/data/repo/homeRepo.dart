import 'package:chat75/core/DB/dbService.dart';
import 'package:chat75/featuers/Home/data/model/roomModel.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/DB/Failure.dart';
import '../../../../core/DB/SupabseService.dart';
import '../../../Auth/data/model/UserInfoModel.dart';

class HomeRepo {
  DbService dbService;
  HomeRepo(this.dbService);
  SupabseService supabseService = SupabseService();

  Future<Either<Failure, UserInfoModel>> getUserInfo(userid) async {
    try {
      final row = await dbService.getSingleData("userInfo", "UID", userid);
      final user = UserInfoModel.fromJson(row);
      print("users ${user.UID}");
      return Right(user);
    } catch (e) {
      return Left(DBFailure("the error is $e"));
    }
  }

  // create room
// creatmessgae  ? (con , idroom , creatat , message , antherid )
  // get all meassage stream
  Future<Either<Failure, String>> createRoom(
      String myId, String antherId) async {
    //123 // 234
    // 234 +  123// id ?
    final sortId = [myId, antherId]..sort();
    final idRoom = '${sortId[0]}-${sortId[1]}';
    // 153434v
    // / 26242233  //id ? m3tmlsh tane : create
    RoomModel room = RoomModel(
        id: idRoom, lastMessage: "", unreadMessages: 0, members: sortId);
    try {
      // check if id ? not create ===> upsert
      await supabseService.client
          .from("rooms")
          .upsert(room.toJson(), onConflict: 'id');
      return Right("Success created room");
    } catch (e) {
      return Left(DBFailure("the error is $e"));
    }
  }

  Stream<List<RoomModel>> getAllRooms() {
    // events => data (map ) = Roommodel ,
    try {
      final myid = supabseService.client.auth.currentUser!.id;
      final stream =
          supabseService.client.from("rooms").stream(primaryKey: ['id']);

      final allRooms = stream.map((e) {
        return e
            .map((e) => RoomModel.fromJson(e))
            .where((room) => room.members.contains(myid))
            .toList();
      });
      print("allRooms $allRooms");

      return allRooms;
    } catch (e) {
      throw Exception("the error is $e");
    }
  }

  // /// Returns a stream that emits Either<Failure, List<RoomModel>>
  // Stream<Either<Failure, List<RoomModel>>> getAllRooms() {
  //   final myId = supabseService.client.auth.currentUser!.id;
  //
  //   Stream<Either<Failure, List<RoomModel>>> roomStream;
  //   try {
  //     roomStream = supabseService.client
  //         .from('rooms')
  //         .stream(primaryKey: ['id'])
  //         .map<Either<Failure, List<RoomModel>>>(
  //           (rows) => Right(rows.map(RoomModel.fromJson).toList()),
  //         )
  //         .handleError((error, stackTrace) {
  //           return Left(DBFailure('Realtime error: $error'));
  //         });
  //   } catch (e) {
  //     roomStream = Stream.value(Left(DBFailure('Sync error: $e')));
  //   }
  //
  //   return roomStream;
  // }

// get all room
}
