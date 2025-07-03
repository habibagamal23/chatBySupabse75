import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/DB/SupabseService.dart';
import '../../../../core/routing/router_generation_config.dart';

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
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouterGeneration.conacts);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
