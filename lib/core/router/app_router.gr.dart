// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../presentation/screen/home_screen.dart' as _i2;
import '../../presentation/screen/login_screen.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          LoginRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/home-screen',
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home-screen',
        );

  static const String name = 'HomeRoute';
}
