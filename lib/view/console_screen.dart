import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:rcc/controller/joystick_controller.dart';

class ConsoleScreen extends StatefulWidget {
  final BluetoothConnection connection;

  const ConsoleScreen({
    super.key,
    required this.connection,
  });

  @override
  State<ConsoleScreen> createState() => _ConsoleScreenState();
}

class _ConsoleScreenState extends State<ConsoleScreen> {
  final JoystickController controller = Get.put(JoystickController());

  bool isEventActive = false;

  void _sendMessage(String command) async {
    Uint8List data = Uint8List.fromList(utf8.encode("$command\r\n"));

    widget.connection.output.add(data);
    await widget.connection.output.allSent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        return SafeArea(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  "assets/image/console_controller_image.png",
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 140),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onPanStart: (details) {
                          controller.center.value = details.localPosition;
                          controller.movement.value = const Offset(0, 0);
                          _handleDirectionEvent('start');
                        },
                        onPanUpdate: (details) {
                          controller.updatePosition(details);
                          _handleDirectionEvent('update');
                        },
                        onPanEnd: (details) {
                          controller.movement.value = const Offset(0, 0);
                          _sendMessage("S");
                          _handleDirectionEvent('end');
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey[300],
                          child: Transform.translate(
                            offset: controller.movement.value,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onPanStart: (details) {
                          controller.center.value = details.localPosition;
                          controller.movement.value = const Offset(0, 0);
                          _handleDirectionEvent('start');
                        },
                        onPanUpdate: (details) {
                          controller.updatePosition(details);
                          _handleDirectionEvent('update');
                        },
                        onPanEnd: (details) {
                          controller.movement.value = const Offset(0, 0);
                          _sendMessage("S");
                          _handleDirectionEvent('end');
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey[300],
                          child: Transform.translate(
                            offset: controller.movement.value,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: GestureDetector(
              //     onTap: () async => await _disconnectAllDevices(),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.redAccent,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: const Padding(
              //         padding: EdgeInsets.all(8),
              //         child: Text(
              //           "블루투스 연결 해제",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }

  void _handleDirectionEvent(String state) {
    if (controller.movement.value.dy < -10) {
      // 위로 이동
      _sendMessage("F");
      print('위로 이동: 상태 - $state');
    } else if (controller.movement.value.dy > 10) {
      // 아래로 이동
      _sendMessage("B");
      print('아래로 이동: 상태 - $state');
    }

    if (controller.movement.value.dx == 0 && controller.movement.value.dx == 0) {
      // 아래로 이동
      _sendMessage("S");
      print('정지: 상태 - $state');
    }

    if (controller.movement.value.dx < -10) {
      // 왼쪽으로 이동

      _sendMessage("L");
      print('왼쪽으로 이동: 상태 - $state');
    } else if (controller.movement.value.dx > 10) {
      // 오른쪽으로 이동
      _sendMessage("R");
      print('오른쪽으로 이동: 상태 - $state');
    }
  }
}
