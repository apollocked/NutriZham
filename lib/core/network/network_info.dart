import 'dart:async';

class NetworkInfo {
  const NetworkInfo();

  Future<bool> get isConnected async {
    try {
      final result = await _checkConnectivity();
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _checkConnectivity() async {
    return true;
  }
}
