import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/core/error/failures.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/data/model/auth/auth_success_response.dart';

import '../../core/error/exceptions.dart';
import '../../core/platform/network_info.dart';
import '../../core/resource/const/shared_preference_keys.dart';
import '../../core/resource/const/urls.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSuccessResponse>> userRegister(
      String userName, String profileName, String password);

  Future<Either<Failure, AuthSuccessResponse>> userLogin(
      String userName, String password);

  Future<Either<Failure, AuthSuccessResponse>> checkLoginStatusCache();

  Future<Either<Failure, bool>> userLogout();
}

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.networkInfo);

  @override
  Future<Either<Failure, AuthSuccessResponse>> checkLoginStatusCache() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(userToken);
    if (token != null) {
      var username = prefs.getString(userName);
      var userprofilename = prefs.getString(userProfileName);
      return Right(AuthSuccessResponse(
          data: UserData(
              username: username, profileName: userprofilename, token: token)));
    }
    return Left(CacheFailure());
  }

  @override
  Future<Either<Failure, AuthSuccessResponse>> userLogin(
      String userName, String password) async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());

    try {
      final url = Uri.http(baseUrl, loginUrl);
      print("URL login remote data source: $url");
      final response = await http
          .post(
        url,
        headers: {'Accept': '*/*', 'Content-Type': "application/json"},
        body: jsonEncode({
          'username': userName,
          'password': password,
        }),
      )
          .timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("Time Out");
      });

      print("Response Login: $response");

      if (response.statusCode == 200) {
        AuthSuccessResponse authSuccessResponse =
            AuthSuccessResponse.fromJson(jsonDecode(response.body));
        // Cache to Shared Pref
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            userToken, authSuccessResponse.data?.token ?? "-");
        await prefs.setString(
            userName, authSuccessResponse.data?.username ?? "guest_user");
        await prefs.setString(
            userProfileName, authSuccessResponse.data?.profileName ?? "Guest");
        await prefs.setInt(userID, authSuccessResponse.data?.id ?? 0);
        return Right(authSuccessResponse);
      } else {
        throw ServerException();
      }
    } on ServerException {
      return Left(ServerFailure());
    } on TimeoutException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AuthSuccessResponse>> userRegister(
      String userName, String profileName, String password) async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());

    try {
      final url = Uri.http(baseUrl, registerUrl);
      print("URL register remote data source: $url");
      final response = await http
          .post(
        url,
        headers: {'Accept': '*/*', 'Content-Type': "application/json"},
        body: jsonEncode({
          'username': userName,
          'profileName': profileName,
          'password': password,
        }),
      )
          .timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("Time Out");
      });

      print("Response Register: $response");

      if (response.statusCode == 200) {
        AuthSuccessResponse authSuccessResponse =
            AuthSuccessResponse.fromJson(jsonDecode(response.body));
        return Right(authSuccessResponse);
      } else {
        throw ServerException();
      }
    } on ServerException {
      return Left(ServerFailure());
    } on TimeoutException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    return Right(await prefs.clear());
  }
}
