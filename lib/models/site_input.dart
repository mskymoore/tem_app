import 'package:formz/formz.dart';

enum SiteValidationError { empty }

class SiteInput extends FormzInput<String, SiteValidationError> {
  const SiteInput.pure() : super.pure('');
  const SiteInput.dirty([String value = '']) : super.dirty(value);

  @override
  SiteValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : SiteValidationError.empty;
  }
}
