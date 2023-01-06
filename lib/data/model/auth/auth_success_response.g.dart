// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthSuccessResponse _$$_AuthSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    _$_AuthSuccessResponse(
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_AuthSuccessResponseToJson(
        _$_AuthSuccessResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      id: json['id'] as int?,
      username: json['username'] as String?,
      profileName: json['profileName'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profileName': instance.profileName,
      'token': instance.token,
    };
