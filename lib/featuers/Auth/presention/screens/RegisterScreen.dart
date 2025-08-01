import 'package:chat75/core/service_locator/service_locator.dart';
import 'package:chat75/core/widgets/custom_text_field.dart';
import 'package:chat75/featuers/Auth/presention/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/router_generation_config.dart';
import '../../../../core/widgets/primay_button_widget.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
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
              CustomTextField(
                hintText: "username",
                controller: usernameController,
              ),
              CustomTextField(
                hintText: "phone",
                controller: phoneController,
              ),
              TextButton(
                  onPressed: () {
                    context.push(RouterGeneration.login);
                  },
                  child: Text("Login")),
              state is AuthLoading
                  ? CircularProgressIndicator()
                  : PrimayButtonWidget(
                      buttonText: "Register",
                      onPress: () {
                        context.read<AuthCubit>().registerUser(
                            emailController.text,
                            passController.text,
                            usernameController.text,
                            phoneController.text);
                      },
                    )
            ],
          );
        }, listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("register Succ with Mail ${state.email}")));
            context.go(RouterGeneration.home);
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
// save user login
// logout
// save user info when is register
// get all user
// update user
