import 'package:chat75/core/service_locator/service_locator.dart';
import 'package:chat75/core/widgets/custom_text_field.dart';
import 'package:chat75/featuers/Auth/presention/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/primay_button_widget.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
          return Column(
            children: [
              CustomTextField(
                hintText: "email",
                controller: emailController,
              ),
              CustomTextField(
                hintText: "password",
                controller: passController,
              ),
              state is AuthLoading
                  ? CircularProgressIndicator()
                  : PrimayButtonWidget(
                      buttonText: "Register",
                      onPress: () {
                        context.read<AuthCubit>().registerUser(
                            emailController.text, passController.text);
                      },
                    )
            ],
          );
        }, listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("register Succ with Mail ${state.email}")));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("register Error ${state.message}")));
          }
        }),
      ),
    );
  }
}

// framecallback