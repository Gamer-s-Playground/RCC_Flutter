import 'package:get/get.dart';
import 'package:rcc/controller/bluetooth_controller.dart';
import 'package:rcc/model/device_model.dart';

class BluetoothSearchController extends GetxController {
  final _result = Rx<List<DeviceModel>>([]);

  List<DeviceModel> get result => _result.value;

  @override
  void onInit() {
    super.onInit();
    startScan();
  }

  void startScan() {
    _result.bindStream(BluetoothController.getDevices());
  }
}
