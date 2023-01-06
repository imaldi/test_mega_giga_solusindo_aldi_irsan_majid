// To parse this JSON data, do
//
//     final authSuccessResponse = authSuccessResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'auth_success_response.freezed.dart';
part 'auth_success_response.g.dart';

AuthSuccessResponse authSuccessResponseFromJson(String str) => AuthSuccessResponse.fromJson(json.decode(str));

String authSuccessResponseToJson(AuthSuccessResponse data) => json.encode(data.toJson());

@freezed
class AuthSuccessResponse with _$AuthSuccessResponse {
  const factory AuthSuccessResponse({
    UserData? data,
    String? message,
    String? status,
  }) = _AuthSuccessResponse;

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) => _$AuthSuccessResponseFromJson(json);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    int? id,
    String? username,
    String? profileName,
    String? token,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
