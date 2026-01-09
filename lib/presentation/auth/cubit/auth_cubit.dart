import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/domain/repo/auth_repo.dart';
import 'package:chat/presentation/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepo _authRepo = getIt();

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    if (!isClosed) {
      emit(RegisterLoading());
    }
    var response = await _authRepo.registerUser(
      email: email,
      password: password,
      name: name,
    );
    switch (response) {
      case Success<UserModel>():
        if (!isClosed) {
          emit(RegisterSuccess(response.data!));
        }
      case Failure<UserModel>():
        if (!isClosed) {
          emit(RegisterFailure(message: response.message ?? 'null'));
        }
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    if (!isClosed) {
      emit(LoginLoading());
    }
    var response = await _authRepo.loginUser(email: email, password: password);
    switch (response) {
      case Success<String>():
        if (!isClosed) {
          emit(LoginSuccess(response.data!));
        }
      case Failure<String>():
        if (!isClosed) {
          emit(LoginFailure(message: response.message ?? "'Failed to Login'"));
        }
    }
  }
}
