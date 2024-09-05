import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:rcc/controller/joystick_controller.dart';
import 'package:rcc/model/device_model.dart';
import 'package:rcc/view/disconnect_screen.dart';

class ConnectScreen extends StatefulWidget {
  final DeviceModel deviceModel;
  final bool current;

  const ConnectScreen({
    super.key,
    required this.deviceModel,
    this.current = false,
  });

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final JoystickController controller = Get.put(JoystickController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DisconnectScreen(),
      // body: Obx(() {
      //   return SafeArea(
      //     child: Stack(
      //       children: [
      //         Center(
      //           child: Image.asset(
      //             "assets/image/console_controller_image.png",
      //           ),
      //         ),
      //         Padding(
      //           padding:
      //               const EdgeInsets.symmetric(horizontal: 140),
      //           child: Center(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 GestureDetector(
      //                   onPanStart: (details) {
      //                     controller.center.value = details.localPosition;
      //                     controller.movement.value = Offset(0, 0);
      //                   },
      //                   onPanUpdate: (details) {
      //                     controller.updatePosition(details);
      //                   },
      //                   onPanEnd: (details) {
      //                     controller.movement.value = Offset(0, 0);
      //                   },
      //                   child: CircleAvatar(
      //                     radius: 70,
      //                     backgroundColor: Colors.grey[300],
      //                     child: Transform.translate(
      //                       offset: controller.movement.value,
      //                       child: CircleAvatar(
      //                         radius: 30,
      //                         backgroundColor: Colors.grey[700],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 GestureDetector(
      //                   onPanStart: (details) {
      //                     controller.center.value = details.localPosition;
      //                     controller.movement.value = Offset(0, 0);
      //                   },
      //                   onPanUpdate: (details) {
      //                     controller.updatePosition(details);
      //                   },
      //                   onPanEnd: (details) {
      //                     controller.movement.value = Offset(0, 0);
      //                   },
      //                   child: CircleAvatar(
      //                     radius: 70,
      //                     backgroundColor: Colors.grey[300],
      //                     child: Transform.translate(
      //                       offset: controller.movement.value,
      //                       child: CircleAvatar(
      //                         radius: 30,
      //                         backgroundColor: Colors.grey[700],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      // }),
    );
  }
}
