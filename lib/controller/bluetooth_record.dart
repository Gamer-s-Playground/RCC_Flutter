import 'package:shared_preferences/shared_preferences.dart';

class BluetoothRecord {
  static void saveDevice(String deviceId) {
    SharedPreferences.getInstance().then((prefs) {
      List<String>? deviceList =
          prefs.getStringList("deviceListKey") ?? [];

      if (!deviceList.contains(deviceId)) {
        deviceList.add(deviceId);
        prefs.setStringList("deviceListKey", deviceList);
      }
    });
  }
}
