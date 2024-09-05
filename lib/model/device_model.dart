import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceModel {
  BluetoothDevice? device;
  late String name;
  late DeviceIdentifier id;
  late bool isConnected;

  DeviceModel(
      {required this.device,
        required this.name,
        required this.id,
        required this.isConnected});

  factory DeviceModel.fromScan(ScanResult result) {
    return DeviceModel(
      device: result.device,
      name: result.device.advName,
      id: result.device.remoteId,
      isConnected: false,
    );
  }

  factory DeviceModel.fromAlreadyConnect(BluetoothDevice device) {
    return DeviceModel(
      device: device,
      name: device.advName,
      id: device.remoteId,
      isConnected: true,
    );
  }
}
