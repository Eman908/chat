import 'package:chat/core/error/results.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseDataSource {
  Future<Results<User>> registerUser({
    required String email,
    required String password,
    required String name,
  });
  Future<Results<User>> loginUser({
    required String email,
    required String password,
  });
}
