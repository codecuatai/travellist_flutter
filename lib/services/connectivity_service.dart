import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  ConnectivityService._internal();

  static ConnectivityService get instance => _instance;

  /// Kiểm tra xem có kết nối mạng hay không
  Future<bool> hasInternetConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  /// Lắng nghe thay đổi kết nối mạng
  Stream<bool> onConnectivityChanged() {
    return Connectivity().onConnectivityChanged.map(
      (result) => result != ConnectivityResult.none,
    );
  }
}
