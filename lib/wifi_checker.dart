import 'wifi_service.dart';

class WifiChecker {
  final WifiService _wifiService;

  final String allowedSSID;
  final String allowedBSSID;

  WifiChecker({
    required this.allowedSSID,
    required this.allowedBSSID,
    required WifiService wifiService,
  }) : _wifiService = wifiService;

  Future<(bool, String?, String?)> checkConnection() async {
    final wifiName = await _wifiService.getWifiName();
    final wifiBSSID = await _wifiService.getWifiBSSID();

    final isConnected = wifiName == allowedSSID && wifiBSSID == allowedBSSID.toLowerCase();

    return (isConnected, wifiName, wifiBSSID);
  }
}
