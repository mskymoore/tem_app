import 'package:formz/formz.dart';

RegExp hoursRegExp = new RegExp(r"^[0-9]{1,2}\.[0-9]{1,2}$|^[0-9]{1,2}$");

enum HoursValidationError { empty, incorrectFormat }

class HoursInput extends FormzInput<String, HoursValidationError> {
  const HoursInput.pure() : super.pure('');
  const HoursInput.dirty([String value = '']) : super.dirty(value);

  @override
  HoursValidationError validator(String value) {
    if (value.isNotEmpty == true) {
      if (hoursRegExp.hasMatch(value) && double.parse(value) <= 24) {
        return null;
      } else {
        return HoursValidationError.incorrectFormat;
      }
    } else {
      return HoursValidationError.empty;
    }
  }
}
