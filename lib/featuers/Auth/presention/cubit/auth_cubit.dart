import 'package:chat75/featuers/Auth/data/repo/AuthRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  AuthRepo authRepo;

  registerUser(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.register(email, password);
    result.fold(
        (f) => emit(AuthError(f.message)), (r) => emit(AuthSuccess(r!.email!)));
  }

  loginUser(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.login(email, password);
    result.fold(
        (f) => emit(AuthError(f.message)), (r) => emit(AuthSuccess(r!.email!)));
  }
}
