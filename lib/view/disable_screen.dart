import 'package:flutter/material.dart';

class DisableScreen extends StatelessWidget {
  const DisableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Text(
        "기기의 블루투스가 꺼져있습니다.",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
