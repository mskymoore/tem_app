import 'dart:async';

import 'package:tem_app/bloc/auth/auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tem_app/user/user.dart';
import 'package:tem_app/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepo authenticationRepository,
    @required UserRepo userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    print('loading authentication state ${json['status']}');
    if (json['status'] == AuthenticationStatus.authenticated.toString()) {
      add(AuthenticationStatusChanged(AuthenticationStatus.authenticated));
      return AuthenticationState.authenticated(User.fromJson(json['user']));
    } else {
      add(AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
      print('loading authentication state ${json['status']}');
      return AuthenticationState.unauthenticated();
    }
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    print('storing authentication state ${state.status.toString()}');
    return <String, dynamic>{
      "status": state.status.toString(),
      "user": state.user,
    };
  }

  final AuthenticationRepo _authenticationRepository;
  final UserRepo _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    print(event.status.toString());
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  Future<User> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
