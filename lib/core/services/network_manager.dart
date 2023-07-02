import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  NetworkManager._();
  static Future<bool> get isConnected async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return !(connectivityResult == ConnectivityResult.none);
  }
}
