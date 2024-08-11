import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'models/models.dart';

abstract class UserRepository {
  Stream<User?> get user;
  Future<MyUser> signUp(MyUser myUser, String password);
  Future<void> setUserData(MyUser MyUser);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> sendResetEmail(String email);
  Future<String> sendPhoneNumberVerification(String phoneNumber);
  Future<String> uploadPicture(String imageFilePath, String userId);
  Future<String> uploadExternalPicture(File imageFile,String userId);
  Future<void> verifyPhoneNumber(String smsCode,String phoneNumber);
  Future<MyUser> getCurrentUser();
  Future<MyUser> getUser(String field, String input);
  Future<MyUser> signInWithGoogle();

}
