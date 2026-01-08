import 'package:chat/core/di/di.dart';
import 'package:chat/core/error/results.dart';
import 'package:chat/core/error/safe_call.dart';
import 'package:chat/data/data_source/contract/firebase_data_source.dart';
import 'package:chat/data/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirebaseDataSource)
class FirebaseDataSourceImpl implements FirebaseDataSource {
  final FirebaseService _firebaseService = getIt();

  @override
  Future<Results<User>> registerUser({
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      var response = await _firebaseService.registerUser(
        email: email,
        password: password,
      );
      if (response.user?.uid.isEmpty ?? true) {
        return Failure(message: 'Something Wrong');
      }
      return Success(response.user);
    });
  }

  @override
  Future<Results<User>> loginUser({
    required String email,
    required String password,
  }) {
    return safeCall(() async {
      var response = await _firebaseService.loginUser(
        email: email,
        password: password,
      );
      if (response.user?.uid.isEmpty ?? true) {
        return Failure(message: 'Failed to Login');
      }
      return Success(response.user);
    });
  }
}
