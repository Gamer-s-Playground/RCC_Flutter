import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rcc/model/device_model.dart';

class BluetoothService {
  static Stream<List<DeviceModel>> getDevices() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    return FlutterBluePlus.scanResults.map((results) {
      List<DeviceModel> devices = [];
      for (var result in results) {
        final device = DeviceModel.fromScan(result);
        devices.add(device);
      }
      return devices;
    });
  }

  static Future<List<DeviceModel>> getConnectedDevices() async {
    List<BluetoothDevice> connects = FlutterBluePlus.connectedDevices; // 이미 List<BluetoothDevice>인 경우
    List<DeviceModel> devices = [];
    for (var connect in connects) {
      final device = DeviceModel.fromAlreadyConnect(connect);
      devices.add(device);
    }
    return devices;
  }
}
