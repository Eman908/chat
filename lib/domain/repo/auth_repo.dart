import 'package:chat/core/error/results.dart';
import 'package:chat/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Results<UserModel>> registerUser({
    required String email,
    required String password,
  });
  Future<Results<String>> loginUser({
    required String email,
    required String password,
  });
}
