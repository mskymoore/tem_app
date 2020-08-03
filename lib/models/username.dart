import 'package:formz/formz.dart';

RegExp emailRegExp = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

enum UsernameValidationError { empty, incorrectFormat }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError validator(String value) {
    if (value.isNotEmpty) {
      if (emailRegExp.hasMatch(value)) {
        return null;
      } else {
        return UsernameValidationError.incorrectFormat;
      }
    } else {
      return UsernameValidationError.empty;
    }
  }
}
