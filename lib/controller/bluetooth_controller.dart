import 'package:rcc/model/device_model.dart';
import 'package:rcc/service/bluetooth_service.dart';

class BluetoothController {
  static Stream<List<DeviceModel>> getDevices() =>
      BluetoothService.getDevices();

  static Future<List<DeviceModel>> getConnectedDevices() =>
      BluetoothService.getConnectedDevices();
}
