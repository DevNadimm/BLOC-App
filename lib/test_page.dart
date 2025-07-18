import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'wifi_checker.dart';
import 'wifi_service.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String _message = 'Checking WiFi connection...';
  bool _isConnected = false;

  final _checker = WifiChecker(
    allowedSSID: 'Nahid',
    allowedBSSID: '04:95:e6:9f:65:f8',
    wifiService: WifiService(),
  );

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final granted = await _requestLocationPermission();
    if (!granted) {
      setState(() {
        _message = 'Location permission is required to get WiFi info.';
      });
      return;
    }

    final (connected, name, bssid) = await _checker.checkConnection();

    setState(() {
      _isConnected = connected;
      _message = connected
          ? '✅ Connected to School WiFi\n\nSSID: $name\nBSSID: $bssid'
          : '❌ Not connected to school WiFi.\n\nDetected:\nSSID: $name\nBSSID: $bssid';
    });
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isGranted) return true;

    final result = await Permission.locationWhenInUse.request();
    return result.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WiFi Check')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: _isConnected ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
