import 'package:formz/formz.dart';

enum EquipValidationError { empty }

class EquipInput extends FormzInput<String, EquipValidationError> {
  const EquipInput.pure() : super.pure('');
  const EquipInput.dirty([String value = '']) : super.dirty(value);

  @override
  EquipValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : EquipValidationError.empty;
  }
}
