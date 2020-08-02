import 'package:formz/formz.dart';

enum RegionValidationError { empty }

class RegionInput extends FormzInput<String, RegionValidationError> {
  const RegionInput.pure() : super.pure('');
  const RegionInput.dirty([String value = '']) : super.dirty(value);

  @override
  RegionValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : RegionValidationError.empty;
  }
}
