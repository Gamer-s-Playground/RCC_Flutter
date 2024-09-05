import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoystickController extends GetxController {
  Rx<Offset> center = Offset(0, 0).obs;

  Rx<Offset> movement = Offset(0, 0).obs;

  Rx<Offset> circle = Offset(0, 0).obs;

  double radius = 50;

  updatePosition(DragUpdateDetails position) {
    movement.value = position.localPosition - center.value;

    double distance = movement.value.distance;

    if (distance > radius) {
      movement.value = movement.value * (radius / distance);
    }

    circle.value += movement.value * 0.1;
  }
}
