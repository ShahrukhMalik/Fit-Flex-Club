import 'package:equatable/equatable.dart';

/// Failures abstract class for List of properties failures
abstract class Failures extends Equatable {
  final String? message;
  final String? code;

  const Failures({required this.code, required this.message});

  @override
  List<Object?> get props => [message];
}

/// General Failures
/// this class is used to show Server Failures
class ServerFailure extends Failures {
  const ServerFailure({String? message, String? code})
      : super(code: code ?? '', message: message ?? '');
}

/// this class is used to show cache failures
class CacheFailure extends Failures {
  const CacheFailure({String? message, String? code})
      : super(code: code ?? '', message: message ?? '');
}

/// General Failures
/// this class is used to show network Failures
class NetworkFailure extends Failures {
  const NetworkFailure({String? message, String? code})
      : super(code: code ?? '', message: message ?? '');
}
