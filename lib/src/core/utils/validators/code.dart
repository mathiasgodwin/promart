import 'package:formz/formz.dart';

enum CodeError { empty, invalid }

class Code extends FormzInput<String, CodeError> {
  const Code.pure() : super.pure('');
  const Code.dirty([String value = '']) : super.dirty(value);

  @override
  CodeError? validator(String value) {
    if (value.isNotEmpty == false) {
      return CodeError.empty;
    }
    return value.length >= 2 ? null : CodeError.invalid;
  }
}
