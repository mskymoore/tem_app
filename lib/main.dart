import 'package:tem_app/bloc/auth/auth.dart';
import 'package:tem_app/user/user.dart';
import 'package:flutter/widgets.dart';
import 'package:tem_app/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  runApp(App(
    authenticationRepository: AuthenticationRepo(),
    userRepository: UserRepo(),
  ));
}
