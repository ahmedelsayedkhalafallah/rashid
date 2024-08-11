//import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:user_repository/src/entities/entities.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String phoneNumber;
   String profilePictureUrl;
  final bool isVerified;
  final Map<String,dynamic> mySyllables;

  MyUser({
    required this.email,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.isVerified,
    required this.mySyllables
  });

  static final empty = MyUser(
      email: '',
      userId: '',
      name: '',
      phoneNumber: '',
      profilePictureUrl: '',
      isVerified: false,
      mySyllables: {});

  MyUser copyWith(
      {String? userId,
      String? email,
      String? name,
      String? phoneNumber,
      String? profilePictureUrl,
      bool? isVerified,
      Map<String,dynamic>? mySyllables}) {
    return MyUser(
        email: email ?? this.email,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        isVerified: isVerified ?? this.isVerified,
        mySyllables: mySyllables ?? this.mySyllables);
  }

  UserEntity toEntity() {
    return UserEntity(
        email: email,
        userId: userId,
        name: name,
        phoneNumber: phoneNumber,
        profilePictureUrl: profilePictureUrl,
        isVerified: isVerified,
        mySyllables: mySyllables);
  }

  static MyUser fromEntity(UserEntity userEntiy) {
    return MyUser(
      email: userEntiy.email,
      userId: userEntiy.userId,
      name: userEntiy.name,
      phoneNumber: userEntiy.phoneNumber,
      profilePictureUrl: userEntiy.profilePictureUrl,
      isVerified: userEntiy.isVerified,
      mySyllables: userEntiy.mySyllables
    );
  }

  @override
  List<Object?> get props =>
      [userId, email, name, phoneNumber, profilePictureUrl, isVerified];
}
