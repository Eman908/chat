import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/data/data_source/contract/firebase_data_source.dart';
import 'package:chat/data/models/user_model.dart';
import 'package:chat/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final FirebaseDataSource _firebaseDataSource = getIt();
  final SharedPreferences _preferences = getIt();
  @override
  Future<Results<UserModel>> registerUser({
    required String email,
    required String password,
  }) async {
    var response = await _firebaseDataSource.registerUser(
      email: email,
      password: password,
    );
    switch (response) {
      case Success<User>():
        UserModel user = UserModel(
          response.data?.email ?? '',
          response.data?.displayName ?? '',
          response.data?.uid ?? '',
        );
        return Success(user);
      case Failure<User>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<String>> loginUser({
    required String email,
    required String password,
  }) async {
    var response = await _firebaseDataSource.loginUser(
      email: email,
      password: password,
    );
    switch (response) {
      case Success<User>():
        final token = await response.data?.getIdToken();
        await _preferences.setString(AppConstants.kToken, token ?? '');
        await _preferences.setString(
          AppConstants.kEmail,
          response.data?.email ?? '',
        );
        await _preferences.setString(
          AppConstants.kName,
          response.data?.displayName ?? '',
        );
        return Success('Login Success');
      case Failure<User>():
        return Failure(message: response.message);
    }
  }
}
