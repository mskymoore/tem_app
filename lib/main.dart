import 'package:tem_app/bloc/auth/auth.dart';
import 'package:tem_app/user/user.dart';
import 'package:flutter/widgets.dart';
import 'package:tem_app/app.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepo(),
    userRepository: UserRepo(),
  ));
}
