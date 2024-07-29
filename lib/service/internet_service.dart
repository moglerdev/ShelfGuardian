import 'package:connectivity_plus/connectivity_plus.dart';

abstract class InternetService {
  Future<bool> checkConnection();
  static InternetService create() {
    return ConnectivityInternetService();
  }
}

class ConnectivityInternetService implements InternetService {
  @override
  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      // Connected to either mobile data or Wi-Fi
      return true;
    } else {
      // Not connected to any network
      return false;
    }
  }
}
