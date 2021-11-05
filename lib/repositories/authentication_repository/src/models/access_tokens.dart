import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'access_tokens.g.dart';

@JsonSerializable()
class AccessTokens extends Equatable {
  final String? accessToken;
  final String? refreshToken;

  const AccessTokens({
    this.accessToken,
    this.refreshToken,
  });

  @override
  List<String?> get props => [
        accessToken,
        refreshToken,
      ];

  factory AccessTokens.fromJson(Map<String, dynamic> json) =>
      _$AccessTokensFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokensToJson(this);
}
