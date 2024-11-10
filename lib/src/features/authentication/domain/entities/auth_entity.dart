// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? password;

  const AuthEntity({
    required this.email,
     this.uid,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password,uid];
}
