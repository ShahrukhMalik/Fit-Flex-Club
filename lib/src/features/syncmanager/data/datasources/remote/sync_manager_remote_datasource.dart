import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/util/error/exceptions.dart';
import 'package:injectable/injectable.dart';

abstract class SyncManagerRemoteDatasource {
  ///
  Future<Stream<bool>> isOnline();
}

@Singleton(as: SyncManagerRemoteDatasource)
class SyncManagerRemoteDatasourceImpl extends SyncManagerRemoteDatasource {
  final Connectivity connectivity;
  final FirebaseAuth auth;
  final FirebaseFirestore remoteDb;

  SyncManagerRemoteDatasourceImpl(
    this.auth,
    this.remoteDb, {
    required this.connectivity,
  });
  @override
  Future<Stream<bool>> isOnline() async {
    try {
      final checkConnectivity = await connectivity.checkConnectivity();

      return connectivity.onConnectivityChanged.asBroadcastStream().map(
        (event) {
          final connectionResult = event[0];
          if (connectionResult == ConnectivityResult.none) {
            return false;
          } else {
            return true;
          }
        },
      );
    } catch (err) {
      throw ServerException(errorMessage: err.toString());
    }
  }
}
