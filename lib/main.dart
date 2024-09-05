import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rcc/controller/joystick_controller.dart';
import 'package:rcc/core/binding/init_binding.dart';
import 'package:rcc/view/connect_screen.dart';
import 'package:rcc/view/disconnect_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      home: const DisconnectScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
