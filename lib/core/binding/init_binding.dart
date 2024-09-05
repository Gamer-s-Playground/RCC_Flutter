import 'package:get/get.dart';
import 'package:rcc/controller/bluetooth_check_controller.dart';
import 'package:rcc/controller/bluetooth_connect_controller.dart';
import 'package:rcc/controller/joystick_controller.dart';


class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JoystickController(), fenix: true);
    Get.put(BluetoothCheckController(), permanent: true);
    Get.put(BluetoothConnectController(), permanent: true);
  }
}
