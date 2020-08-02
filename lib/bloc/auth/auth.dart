import 'dart:async';
import 'package:meta/meta.dart';
import 'package:tem_app/rest/auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepo {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);

    final formData = {'email': email, 'password': password};

    final loginWasSuccess = await tokenLogin(formData);

    if (loginWasSuccess) {
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  void logOut() {
    tokenLogout();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
