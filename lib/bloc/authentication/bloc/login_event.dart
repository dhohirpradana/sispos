import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String nip;
  final String password;

  const LoginButtonPressed({
    @required this.nip,
    @required this.password,
  });

  @override
  List<Object> get props => [nip, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $nip, password: $password }';
}
