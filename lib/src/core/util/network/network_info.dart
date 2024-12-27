import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

@Singleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    var result = await _connectivity.checkConnectivity();
    return (result[0] != ConnectivityResult.wifi ||
        result[0] != ConnectivityResult.mobile);
  }
}
