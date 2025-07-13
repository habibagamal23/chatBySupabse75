import 'package:chat75/core/DB/SupabseService.dart';
import 'package:chat75/featuers/Home/data/model/roomModel.dart';
import 'package:chat75/featuers/Home/presention/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final RoomModel? room;
  const ChatScreen({super.key, required this.room});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MessagesCubit>().getAllMessage(widget.room!.id);
  }

  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myid = SupabseService().client.auth.currentUser!.id;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with ${widget.room!.otherUserInfo!.uesr_name}"),
      ),
      body: Column(
        children: [
          // list

          Expanded(
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoading) {
                  return CircularProgressIndicator();
                }
                if (state is MessagesLoaded) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      bool ismee = state.messages[index].senderId == myid;
                      return Align(
                        alignment: ismee
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ismee ? Colors.blue : Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(state.messages[index].content),
                        ),
                      );
                    },
                  );
                }

                return Text("No chats here ");
              },
            ),
          ),

          // row text , send
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: messageController,
                decoration: InputDecoration(hintText: "Type your message here"),
              )),
              BlocBuilder<MessagesCubit, MessagesState>(
                  builder: (context, state) {
                if (state is SendMessageLoading) {
                  return CircularProgressIndicator();
                }

                return IconButton(
                    onPressed: () {
                      context
                          .read<MessagesCubit>()
                          .sendMessage(widget.room!.id, messageController.text);
                      messageController.clear();
                    },
                    icon: Icon(Icons.send));
              })
            ],
          )
        ],
      ),
    );
  }
}
