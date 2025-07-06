import 'package:chat75/core/service_locator/service_locator.dart';
import 'package:chat75/featuers/Home/presention/screens/homescreen.dart';
import 'package:chat75/featuers/profile/presention/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../featuers/Auth/presention/screens/RegisterScreen.dart';
import '../../featuers/Auth/presention/screens/loginscreen.dart';
import '../../featuers/contacts/presention/contactsScreen.dart';
import '../DB/SupabseService.dart';
import '../DB/dbService.dart';

class RouterGeneration {
  static const String splash = "/splash";
  static const String home = "/home";
  static const String register = "/register";
  static const String login = "/login";
  static const String conacts = "/conacts";
  static const String prfile = "/prfile";
  static GoRouter goRouter = GoRouter(
      initialLocation: register,
      routes: [
        GoRoute(
            path: register,
            builder: (context, state) {
              return Registerscreen();
            }),
        GoRoute(
            path: conacts,
            builder: (context, state) {
              return Contactsscreen();
            }),
        GoRoute(
            path: home,
            builder: (context, state) {
              return Homescreen();
            }),
        GoRoute(
            path: login,
            builder: (context, state) {
              return Loginscreen();
            }),
        GoRoute(
            path: prfile,
            builder: (context, state) {
              return Profilescreen();
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
