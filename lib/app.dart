import 'package:flutter/material.dart';
import 'package:tem_app/bloc/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/bloc/auth/auth_bloc.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';
import 'package:tem_app/bloc/worklog_form/worklog_form_bloc.dart';
import 'package:tem_app/user/user.dart';
import 'package:tem_app/views/views.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepo authenticationRepository;
  final UserRepo userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository,
                    userRepository: userRepository,
                  )),
          BlocProvider(create: (_) => WorklogBloc()),
          BlocProvider(
            create: (_) => WorklogFormBloc(),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      MainPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ));
  }
}
