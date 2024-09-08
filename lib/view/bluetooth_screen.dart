import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:rcc/view/console_screen.dart';
import 'package:rcc/widget/bluetooth_connect_dialog.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  List<BluetoothDevice> _devicesList = [];

  bool _isLoading = false;

  BluetoothConnection? _connection;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  void _initBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }

    await _getBondedDevices();
  }

  Future<void> _getBondedDevices() async {
    List<BluetoothDevice> bondedDevices =
        await FlutterBluetoothSerial.instance.getBondedDevices();

    setState(() {
      _devicesList = bondedDevices;
    });
  }

  Future<void> _startDiscovery() async {
    setState(() {
      _isLoading = true;
      _devicesList = [];
    });

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        _devicesList.add(r.device);
      });
    }).onDone(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _cancelDiscovery() async {
    await FlutterBluetoothSerial.instance.cancelDiscovery();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      bool isConnected = await FlutterBluetoothSerial.instance.isConnected;

      if (isConnected) {
        await FlutterBluetoothSerial.instance.disconnect();
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const BluetoothConnectDialog();
        },
      );
      _connection = await BluetoothConnection.toAddress(device.address);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConsoleScreen(connection: _connection!),
        ),
      );
    } catch (e) {
      print('연결 중 오류가 발생했습니다: $e');
    }
  }

  Future<void> _disconnectAllDevices() async {
    try {
      if (_connection != null && _connection!.isConnected) {
        await _connection!.finish();
      }

    } catch (e) {
      print('연결 해제 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RC Car Controller',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _isLoading ? _cancelDiscovery : _startDiscovery,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? Colors.lightBlue[300]
                              : CupertinoColors.activeGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              if (_isLoading)
                                const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              Text(
                                _isLoading ? "검색 취소" : "주변 기기 검색",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () async => await _disconnectAllDevices(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "블루투스 연결 해제",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _devicesList.length,
                  itemBuilder: (context, index) {
                    BluetoothDevice device = _devicesList[index];

                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: _devicesList.length - 1 == index ? 0 : 12),
                      child: GestureDetector(
                        onTap: () => _connectToDevice(device),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.blueAccent.shade100,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "이름 : [ ${device.name ?? "Unknown"} ]",
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "주소 : [ ${device.address} ]",
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                if (device.isConnected)
                                  const Text(
                                    "연결됨",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (device.isBonded && !device.isConnected)
                                  const Text(
                                    "저장됨",
                                    style: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
