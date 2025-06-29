import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../featuers/Auth/presention/screens/RegisterScreen.dart';

class RouterGeneration {
  static const String splash = "/splash";
  static const String home = "/home";
  static const String register = "/register";

  static GoRouter goRouter = GoRouter(
      initialLocation: register,
      routes: [
        GoRoute(
            path: register,
            builder: (context, state) {
              return Registerscreen();
            }),
      ],
      debugLogDiagnostics: true,
      errorPageBuilder: (context, state) => MaterialPage(
            child: Scaffold(
              body: Center(
                child: Text(state.error.toString()),
              ),
            ),
          ));
}
