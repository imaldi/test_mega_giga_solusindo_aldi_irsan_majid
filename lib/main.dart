import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/core/platform/network_info.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/data/repository/auth_repository.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/presentation/screen/login_screen.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/presentation/state_management/blocs/auth_bloc.dart';
import 'core/router/app_router.gr.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();
  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AuthBloc(AuthRepositoryImpl(NetworkInfoImpl(InternetConnectionChecker()))),
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'App Mega Giga',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}