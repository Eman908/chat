import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/core/error/results.dart';

Future<Results<T>> safeCall<T>(Future<Results<T>> Function() call) async {
  try {
    return await call();
  } on FirebaseAuthException catch (e) {
    return Failure(exception: e, message: _mapFirebaseAuthMessage(e));
  } on FirebaseException catch (e) {
    return Failure(exception: e, message: _mapFirebaseMessage(e));
  } on TimeoutException catch (e) {
    return Failure(exception: e, message: 'Request timeout');
  } on SocketException catch (e) {
    return Failure(exception: e, message: 'No internet connection');
  } on IOException catch (e) {
    return Failure(exception: e, message: 'Network error');
  } catch (e) {
    return Failure(exception: Exception(e.toString()), message: e.toString());
  }
}

String _mapFirebaseAuthMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'weak-password':
      return 'The password provided is too weak';
    case 'email-already-in-use':
      return 'The account already exists for that email';
    case 'user-not-found':
      return 'No user found for that email';
    case 'wrong-password':
      return 'Wrong password provided';
    case 'invalid-email':
      return 'Email address is not valid';
    case 'user-disabled':
      return 'This user account has been disabled';
    case 'too-many-requests':
      return 'Too many login attempts. Please try again later';
    case 'operation-not-allowed':
      return 'Email/password sign-in is not enabled';
    case 'network-request-failed':
      return 'Network error. Please check your connection';
    default:
      return 'Login failed: ${e.message ?? "Unknown error"}';
  }
}

String _mapFirebaseMessage(FirebaseException e) {
  return 'Firebase error: ${e.message ?? "Something went wrong"}';
}
