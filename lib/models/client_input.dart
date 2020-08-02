import 'package:formz/formz.dart';

enum ClientValidationError { empty }

class ClientInput extends FormzInput<String, ClientValidationError> {
  const ClientInput.pure() : super.pure('');
  const ClientInput.dirty([String value = '']) : super.dirty(value);

  @override
  ClientValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : ClientValidationError.empty;
  }
}
