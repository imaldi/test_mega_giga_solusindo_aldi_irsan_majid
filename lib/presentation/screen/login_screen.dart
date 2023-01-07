import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/core/resource/const/colors.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/core/router/app_router.gr.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/presentation/widget/custom_text.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/presentation/widget/my_text_field.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/presentation/widget/my_toast.dart';

import '../state_management/blocs/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var username = "";
  var password = "";
  late TextEditingController usernameTEC;
  late TextEditingController passwordTEC;

  @override
  void initState() {
    super.initState();
    username = "aldi_i_m";
    password = "secret123";
    usernameTEC = TextEditingController(text: username);
    passwordTEC = TextEditingController(text: password);
    context.read<AuthBloc>().add(CheckLoginStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc,AuthState>(
        listener: (context,state){
          if(state is AuthSuccess) {
            context.router.replace(const HomeRoute());
          }
          if(state is AuthCacheNotFound){
            myToast("Ga ada cache");
          }
          if (state is AuthFailed) {
            myToast("Username / Password salah");
          }
        },
        builder: (context,state) {
          print("State is ${state.runtimeType}");
          if(state is AuthFailed || state is AuthCacheNotFound || state is AuthInitial){
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTextField(
                      label: "User Name",
                      controller: usernameTEC,
                    ),
                    MyTextField(
                      label: "Password",
                      obscureText: true,
                      controller: passwordTEC,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LoginEvent(usernameTEC.text, passwordTEC.text));
                        },
                        child: const CustomText(
                          "LOGIN",
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ))
                  ],
                ),
              ),
            );

          }
          if(state is AuthLoading){
            return Center(child: CircularProgressIndicator(color: primaryGreen,),);
          }

          return Center(child: Text("AHAHAHA"),);
        }
      ),
    );
  }
}
