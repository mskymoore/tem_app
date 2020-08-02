import 'package:flutter/material.dart';
import 'package:tem_app/widgets/login_form.dart';
import 'package:tem_app/bloc/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/bloc/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  static const String title = 'Login';
  static const String login = '/login';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => LoginPage(), settings: RouteSettings(name: login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepo>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
