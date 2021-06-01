import 'package:bloc/bloc.dart';
import 'package:iac/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository = AuthRepository();

  // ignore: sort_constructors_first
  LoginCubit() : super(LoginInitial());

  void login(String email, String pwd) {
    emit(LoadingState());
    _authRepository
        .signIn(email, pwd)
        .then((uid) => {emit(LoginValid())})
        .catchError((onError) => {emit(LoginInvalid())});
  }
}
