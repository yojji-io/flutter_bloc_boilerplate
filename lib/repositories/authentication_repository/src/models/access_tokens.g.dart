// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokens _$AccessTokensFromJson(Map<String, dynamic> json) => AccessTokens(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$AccessTokensToJson(AccessTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
