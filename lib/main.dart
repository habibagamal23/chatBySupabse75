import 'package:chat75/core/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/router_generation_config.dart';
import 'featuers/contacts/presention/cubit/contacts_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://pmykflafxhmykwzxyfcm.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBteWtmbGFmeGhteWt3enh5ZmNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3OTI0NzUsImV4cCI6MjA2NjM2ODQ3NX0.B0F-5VVLamSXL5i1zio-tjOAVE42CeROBoVYiaJ0iT4",
  );
  setupServiceLocator();
  runApp(BlocProvider(
      create: (_) => getIt<ContactsCubit>()..fechConcts(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: RouterGeneration.goRouter,
            title: 'Flutter Demo',
          );
        });
  }
}
