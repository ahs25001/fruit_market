part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, error }

@immutable
class AuthState {
 final AuthStatus? status;
 final String? massage;

 const AuthState({this.status, this.massage});

  AuthState copyWith({AuthStatus? status, String? massage}) => AuthState(
      status: status ?? this.status, massage: massage ?? this.massage);
}

final class AuthInitial extends AuthState {
  AuthInitial() : super(status: AuthStatus.initial);
}
