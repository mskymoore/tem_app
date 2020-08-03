import 'package:formz/formz.dart';

enum EmployeeValidationError { empty }

class EmployeeInput extends FormzInput<String, EmployeeValidationError> {
  const EmployeeInput.pure() : super.pure('');
  const EmployeeInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmployeeValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : EmployeeValidationError.empty;
  }
}
