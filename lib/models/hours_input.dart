import 'package:formz/formz.dart';
import 'package:tem_app/config/constants.dart';

enum HoursValidationError { empty, incorrectFormat }

class HoursInput extends FormzInput<String, HoursValidationError> {
  const HoursInput.pure() : super.pure('');
  const HoursInput.dirty([String value = '']) : super.dirty(value);

  @override
  HoursValidationError validator(String value) {
    if (value.isNotEmpty == true) {
      if (hoursRegExp.hasMatch(value)) {
        return null;
      } else {
        return HoursValidationError.incorrectFormat;
      }
    } else {
      return HoursValidationError.empty;
    }
  }
}
