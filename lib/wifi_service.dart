import 'package:network_info_plus/network_info_plus.dart';

class WifiService {
  final NetworkInfo _networkInfo = NetworkInfo();

  Future<String?> getWifiName() async {
    final name = await _networkInfo.getWifiName();
    return name?.replaceAll('"', '').trim();
  }

  Future<String?> getWifiBSSID() async {
    final bssid = await _networkInfo.getWifiBSSID();
    return bssid?.toLowerCase().trim();
  }
}
