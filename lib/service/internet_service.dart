import 'package:connectivity_plus/connectivity_plus.dart';

/// An abstract class representing an internet service.
abstract class InternetService {
  /// Checks the internet connection.
  Future<bool> checkConnection();

  /// Creates an instance of [InternetService].
  static InternetService create() {
    return ConnectivityInternetService();
  }
}

/// A concrete implementation of [InternetService] using the connectivity package.
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
