import 'package:chat75/core/DB/SupabseService.dart';
import 'package:chat75/featuers/Home/presention/room_cubit.dart';
import 'package:chat75/featuers/contacts/presention/cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/router_generation_config.dart';

class Contactsscreen extends StatelessWidget {
  const Contactsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<ContactsCubit, ContactsState>(builder: (context, state) {
      if (state is ContactsLoading) {
        return CircularProgressIndicator();
      }
      if (state is ContactsError) {
        return Text(state.message);
      }
      if (state is ContactsLoaded) {
        return ListView.builder(
          itemCount: state.contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                final myId = SupabseService().client.auth.currentUser!.id;
                context
                    .read<RoomCubit>()
                    .creatRoom(myId, state.contacts[index].UID);
                context.push(RouterGeneration.home);
              },
              title: Text(state.contacts[index].uesr_name),
              subtitle: Text(state.contacts[index].email),
              trailing: Text(state.contacts[index].phone_num),
            );
          },
        );
      }

      return Container();
    }));
  }
}
