import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.email, this.name);

  final String id;
  final String email;
  final String name;

  @override
  List<Object> get props => [id, email, name];
}
