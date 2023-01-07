import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/core/router/app_router.gr.dart';

import '../state_management/blocs/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthInitial){
            context.router.replace(const LoginRoute());
          }
        },
        builder: (context, state) {
          if(state is AuthSuccess){
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.userData.toJson().toString() ?? ""),
                ElevatedButton(onPressed: (){
                  context.read<AuthBloc>().add(LogoutEvent());
                }, child: const Text("Log Out"))
              ],
            ),);
          }
          return Text("Home");
        },
      ),),);
  }
}
