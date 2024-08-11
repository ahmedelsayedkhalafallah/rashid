import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String phoneNumber;
  final String profilePictureUrl;
  final bool isVerified;
  final Map<String, dynamic> mySyllables;

  const UserEntity({
    required this.email,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.isVerified,
    required this.mySyllables
  });

  Map<String, Object?> toDocument() {
    return {
      "userId": userId,
      "email": email,
      "name": name,
      "phoneNumber": phoneNumber,
      "profilePictureUrl": profilePictureUrl,
      "isVerified": isVerified,
      "mySyllables":mySyllables
    };
  }

  static UserEntity fromDocument(Map<String, dynamic>? document) {
    return UserEntity(
        email: document?['email'],
        userId: document?['userId'],
        name: document?['name'],
        phoneNumber: document?['phoneNumber'],
        profilePictureUrl: document?['profilePictureUrl'],
        isVerified: document?['isVerified'],
        mySyllables: document?['mySyllables']??{});
  }

  @override
  List<Object?> get props => [userId, email, name, phoneNumber, profilePictureUrl, isVerified,mySyllables];
}
