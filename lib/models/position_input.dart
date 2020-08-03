import 'package:formz/formz.dart';

enum PositionValidationError { empty }

class PositionInput extends FormzInput<String, PositionValidationError> {
  const PositionInput.pure() : super.pure('');
  const PositionInput.dirty([String value = '']) : super.dirty(value);

  @override
  PositionValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : PositionValidationError.empty;
  }
}
