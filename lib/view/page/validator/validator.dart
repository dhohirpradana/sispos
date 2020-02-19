import 'package:formini/formini.dart';

class LoginFormValidator implements Validator {
  const LoginFormValidator();

  @override
  Map<String, Exception> validate(Map<String, dynamic> values) {
    final errors = <String, Exception>{};

    if (values['email'] == null || values['email'].isEmpty) {
      errors['email'] = Exception('Email is required');
    } else if (!values['email'].contains('@')) {
      errors['email'] = Exception('Email is invalid');
    }

    if (values['password'] == null || values['password'].isEmpty) {
      errors['password'] = Exception('Password is required');
    }

    return errors;
  }
}