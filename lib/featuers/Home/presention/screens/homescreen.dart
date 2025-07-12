import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/DB/SupabseService.dart';
import '../../../../core/routing/router_generation_config.dart';
import '../room_cubit.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                await SupabseService().signOut();
                context.go(RouterGeneration.register);
              },
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                context.go(RouterGeneration.prfile);
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
        if (state is GetAllRoomsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is GetAllRoomsLoaded) {
          return ListView.builder(
              itemCount: state.rooms.length,
              itemBuilder: (context, index) {
                final room = state.rooms[index];
                return ListTile(
                  title: Text("${room.otherUserInfo?.uesr_name}"),
                  subtitle: Text("${room.lastMessage}"),
                  trailing: Text("${room.unreadMessages}"),
                );
              });
        }
        if (state is GetAllRoomsError) {
          return Text(state.message);
        }

        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouterGeneration.conacts);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
