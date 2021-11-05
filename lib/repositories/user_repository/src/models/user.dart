import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
