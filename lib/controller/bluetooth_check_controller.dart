import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:rcc/view/connect_screen.dart';
import 'package:rcc/view/disable_screen.dart';
import 'package:rcc/view/disconnect_screen.dart';

class BluetoothCheckController extends GetxController {
  final _bluetoothState = Rx<BluetoothAdapterState>(BluetoothAdapterState.unknown);

  set bluetoothState(value) => _bluetoothState.value = value;

  @override
  void onReady() {
    super.onReady();

    ever(_bluetoothState, (_) => moveToPage());

    _bluetoothState.bindStream(FlutterBluePlus.adapterState);
  }

  void moveToPage() {
    if (_bluetoothState.value == BluetoothAdapterState.on) {
      Get.off(() => const DisconnectScreen(), transition: Transition.fadeIn);
    } else {
      Get.off(() => const DisableScreen(), transition: Transition.fadeIn);
    }
  }
}
