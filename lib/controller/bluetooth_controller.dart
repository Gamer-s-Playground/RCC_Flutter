import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothController {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> _devicesList = [];
  bool _isLoading = false;
  BluetoothConnection? _connection;

  // void _initBluetooth() async {
  //
  //   _bluetoothState = await FlutterBluetoothSerial.instance.state;
  //
  //   if (_bluetoothState == BluetoothState.STATE_OFF) {
  //     await FlutterBluetoothSerial.instance.requestEnable();
  //   }
  //
  //   await _getBondedDevices();
  // }
  //
  // Future<void> _getBondedDevices() async {
  //   // Future<void>: 일반 void와 비교하자면 객체로서 반환 값을 처리 할 수 있음.
  //
  //   List<BluetoothDevice> bondedDevices =
  //   await FlutterBluetoothSerial.instance.getBondedDevices();
  //
  //   setState(() {
  //     _devicesList = bondedDevices;
  //   });
  // }
  //
  // Future<void> _startDiscovery() async {
  //   setState(() {
  //     _isLoading = true;
  //     _devicesList = [];
  //   });
  //
  //   FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
  //     // 추상 클래스로서 r은 그냥 변수로 사용
  //
  //     setState(() {
  //       _devicesList.add(r.device);
  //     });
  //   }).onDone(() {
  //     // 콜백함수로서 작업 완료 후, 작업 처리
  //
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }
  //
  // Future<void> _cancelDiscovery() async {
  //   await FlutterBluetoothSerial.instance.cancelDiscovery();
  //
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }
  //
  // Future<void> _connectToDevice(BluetoothDevice device) async {
  //   try {
  //     bool isConnected = await FlutterBluetoothSerial.instance.isConnected;
  //
  //     if (isConnected) {
  //       await FlutterBluetoothSerial.instance.disconnect();
  //     }
  //
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return const BluetoothConnectDialog();
  //       },
  //     );
  //     _connection = await BluetoothConnection.toAddress(device.address);
  //     Navigator.pop(context);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ConsoleScreen(connection: _connection!),
  //       ),
  //     );
  //   } catch (e) {
  //     print('연결 중 오류가 발생했습니다: $e');
  //   }
  // }
  //
  // Future<void> _disconnectAllDevices() async {
  //   try {
  //     if (_connection != null && _connection!.isConnected) {
  //       await _connection!.finish();
  //     }
  //
  //     // 추가적으로 연결된 디바이스가 있다면 여기에 처리를 추가하세요.
  //   } catch (e) {
  //     print('연결 해제 중 오류가 발생했습니다: $e');
  //   }
  // }
}
