import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/profile_cubit.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  late TextEditingController nameController;
  late TextEditingController phonecontroller;
  final ImagePicker picker = ImagePicker();
  File? iamge;

  @override
  initState() {
    super.initState();
    nameController = TextEditingController();
    phonecontroller = TextEditingController();
  }

  pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      iamge = File(image!.path);
    });
    context.read<ProfileCubit>().uploadImage(iamge!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body:
          BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.green,
          ));
        }
      }, builder: (context, state) {
        if (state is ProfileLoading || state is ProfileUpdating) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoaded) {
          nameController.text = state.user.uesr_name;
          phonecontroller.text = state.user.phone_num;
          return Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: iamge != null ? FileImage(iamge!) : null,
                  child: iamge == null ? Icon(Icons.person) : null,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                controller: nameController,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "phone",
                ),
                controller: phonecontroller,
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<ProfileCubit>()
                        .upadteData(nameController.text, phonecontroller.text);
                  },
                  child: Text("update"))
            ],
          );
        }
        return Container();
      }),
    );
  }
}
