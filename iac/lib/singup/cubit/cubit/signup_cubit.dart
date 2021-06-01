import 'package:bloc/bloc.dart';
import 'package:iac/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  AuthRepository _authRepository = AuthRepository();
  // ignore: sort_constructors_first
  SignupCubit() : super(SignupInitial());

  void signUp(String email, String password) {
    emit(SignUpLoading());
    _authRepository
        .signUp(email, password)
        .then((value) => emit(SignUpValid(uid: value.user!.uid)))
        .onError((error, stackTrace) => emit(SignUpInvalid()));
  }
}
