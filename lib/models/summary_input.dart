import 'package:formz/formz.dart';

enum SummaryValidationError { empty }

class SummaryInput extends FormzInput<String, SummaryValidationError> {
  const SummaryInput.pure() : super.pure('');
  const SummaryInput.dirty([String value = '']) : super.dirty(value);

  @override
  SummaryValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : SummaryValidationError.empty;
  }
}
