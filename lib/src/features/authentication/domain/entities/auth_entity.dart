// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? password;
  final bool? isLoggedIn;
  final bool? mailSent;
  // final bool? authenticate;
  final bool? isUserActive;
  final bool? isProfileCreated;
  final bool? isSignedUp;

  const AuthEntity({
    this.email,
    this.uid,
    this.isLoggedIn,
    this.password,
    this.isSignedUp,
    this.isUserActive,
    this.isProfileCreated,
    this.mailSent,
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
        mailSent
        // authenticate
      ];
}
