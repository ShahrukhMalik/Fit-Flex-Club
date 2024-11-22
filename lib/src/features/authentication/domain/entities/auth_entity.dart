// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? password;
  final bool? isLoggedIn;
  final bool? mailSent;
  final DateTime? timeStamp;
  // final bool? authenticate;
  final bool? isUserActive;
  final bool? isTrainer;
  final bool? isProfileCreated;
  final bool? isSignedUp;

  const AuthEntity( {
    this.timeStamp,
    this.email,
    this.uid,
    this.isLoggedIn,
    this.password,
    this.isSignedUp,
    this.isUserActive,
    this.isProfileCreated,
    this.mailSent,
    this.isTrainer,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        uid,
        isLoggedIn,
        isUserActive,
        isProfileCreated,
        isSignedUp,
        mailSent,
        isTrainer
        // authenticate
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'password': password,
      'isLoggedIn': isLoggedIn,
      'mailSent': mailSent,
      'isUserActive': isUserActive,
      'isTrainer': isTrainer,
      'isProfileCreated': isProfileCreated,
      'isSignedUp': isSignedUp,
    };
  }

  factory AuthEntity.fromMap(Map<String, dynamic> map) {
    return AuthEntity(
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      isLoggedIn: map['isLoggedIn'] != null ? map['isLoggedIn'] as bool : null,
      mailSent: map['mailSent'] != null ? map['mailSent'] as bool : null,
      isUserActive: map['isUserActive'] != null ? map['isUserActive'] as bool : null,
      isTrainer: map['isTrainer'] != null ? map['isTrainer'] as bool : null,
      isProfileCreated: map['isProfileCreated'] != null ? map['isProfileCreated'] as bool : null,
      isSignedUp: map['isSignedUp'] != null ? map['isSignedUp'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthEntity.fromJson(String source) => AuthEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
