import 'package:auto_route/auto_route.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/presentation/screen/home_screen.dart';

import '../../presentation/screen/login_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, initial: true),
    AutoRoute(page: HomeScreen,),
  ],
)
class $AppRouter {}