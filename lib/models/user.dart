import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User extends Equatable {
  const User(this.id, this.email, this.name);

  final String id;
  final String email;
  final String name;

  @override
  List<Object> get props => [id, email, name];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
