import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Stream<ConnectivityResult> get onConnectivityChanged;

  Future<bool> get isConnected;

  bool isConnectedFromConnectivityResult(ConnectivityResult? result);
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;

  @override
  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return isConnectedFromConnectivityResult(result);
  }

  @override
  bool isConnectedFromConnectivityResult(ConnectivityResult? result) =>
      result == ConnectivityResult.ethernet ||
      result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi;
}
