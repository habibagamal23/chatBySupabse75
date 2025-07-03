import 'package:chat75/core/widgets/primay_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as Supabase;

import '../../../../core/routing/router_generation_config.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("login"),
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
              TextButton(
                  onPressed: () async {
                    final supabase = Supabase.Supabase.instance.client;
                    await supabase.from('userInfo').insert({
                      'UID': '442526662772',
                      'email': "k@gmail.com",
                      'uesr_name': "karim",
                      'phone_num': "866553553"
                    });
                  },
                  child: Text("insert data test")),
              TextButton(
                  onPressed: () {
                    context.push(RouterGeneration.register);
                  },
                  child: Text("register")),
              state is AuthLoading
                  ? CircularProgressIndicator()
                  : PrimayButtonWidget(
                      buttonText: "Login",
                      onPress: () {
                        context.read<AuthCubit>().loginUser(
                            emailController.text, passController.text);
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
