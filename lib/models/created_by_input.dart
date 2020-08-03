import 'package:formz/formz.dart';

enum CreatedByValidationError { empty }

class CreatedByInput extends FormzInput<String, CreatedByValidationError> {
  const CreatedByInput.pure() : super.pure('');
  const CreatedByInput.dirty([String value = '']) : super.dirty(value);

  @override
  CreatedByValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : CreatedByValidationError.empty;
  }
}
