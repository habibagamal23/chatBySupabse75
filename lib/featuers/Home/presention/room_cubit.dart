import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat75/core/DB/SupabseService.dart';
import 'package:chat75/featuers/Home/data/repo/homeRepo.dart';
import 'package:meta/meta.dart';

import '../data/model/roomModel.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  HomeRepo homeRepo;
  RoomCubit(this.homeRepo) : super(RoomInitial());

  creatRoom(myId, antherId) async {
    emit(CreateRoomLoading());

    final result = await homeRepo.createRoom(myId, antherId);
    result.fold((failure) {
      emit(CreateRoomError(failure.message));
    }, (message) {
      emit(createRommLoaded(message));
    });
  }

  StreamSubscription<List<RoomModel>>? roomSubscription;

  getallRooms() {
    emit(GetAllRoomsLoading());
    try {
      roomSubscription = homeRepo.getAllRooms().listen((rooms) async {
        print("allRooms ${rooms.length}");
        // list rooms => room ? ontherid ? getuser ? = user
        List<RoomModel> roomsWithUsers = [];
        // 1
        for (var room in rooms) {
          // [my , anther ] =e!=my ? anther
          final antherId = room.members
              .where((id) => id != SupabseService().client.auth.currentUser!.id)
              .first;
          // 2
          final user = await homeRepo.getUserInfo(antherId);
          user.fold((failure) {
            emit(GetAllRoomsError(failure.message));
          }, (user) {
            room.otherUserInfo = user;
            roomsWithUsers.add(room);
          });
          // 3
        }

        emit(GetAllRoomsLoaded(roomsWithUsers));
      });
    } catch (e) {
      emit(GetAllRoomsError(e.toString()));
    }
  }
}
