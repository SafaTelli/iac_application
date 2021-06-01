part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpValid extends SignupState {
  String uid = "";
  SignUpValid({
    required this.uid,
  });
}

class SignUpInvalid extends SignupState {}
