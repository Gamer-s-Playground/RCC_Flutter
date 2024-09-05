import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:get/get.dart';
import 'package:rcc/controller/bluetooth_controller.dart';
import 'package:rcc/controller/bluetooth_record.dart';
import 'package:rcc/controller/bluetooth_repository.dart';
import 'package:rcc/model/device_model.dart';

enum Status { loading, loaded }

class BluetoothConnectController extends GetxController {
  final _result = Rx<List<DeviceModel>>([]);
  final _already = Rx<List<DeviceModel>>([]);

  final _status = Status.loaded.obs;

  List<DeviceModel> get result => _result.value;
  List<DeviceModel> get already => _already.value;

  Status get status => _status.value;
  set already(value) => _already.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchAlreadyConnected();
    startScan();
  }

  void fetchAlreadyConnected() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      BluetoothController.getConnectedDevices().then((data) {
        already = data;
        print('새로고침');
      });
    }
  }

  void fabAction() {
    switch (_status.value) {
      case Status.loading:
        stopScan();
        break;
      case Status.loaded:
        startScan();
        break;
    }
  }

  void startScan() {
    _status(Status.loading);
    _result.bindStream(BluetoothController.getDevices());

    _status(Status.loaded);
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
    _status(Status.loaded);
  }

  void removeDevice(int index) {
    _result.value.removeAt(index);
    _result.refresh();
  }

  Future<void> connectDevice(DeviceModel deviceModel) async {
    try {
      await BluetoothRepository.connectDevice(deviceModel).then((value) {
        BluetoothRecord.saveDevice(deviceModel.id.toString());
        debugPrint("연결기록남김");

        result.remove(deviceModel);
        deviceModel.isConnected = true;
        //fetchAlreadyConnected();
        already.add(deviceModel);
        _already.refresh();
        _result.refresh();
      });
    } catch (e) {

    }
  }

  Future<void> disconnect(DeviceModel deviceModel) async {
    try {
      BluetoothRepository.disconnect(deviceModel).then((value) {
        already.remove(deviceModel);
        //fetchAlreadyConnected();
        _already.refresh();
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<int>> searchService(DeviceModel deviceModel) async {
    try {
      return BluetoothRepository.searchService(deviceModel);
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  void sendData(BluetoothDevice device, String data) {
    try {
      BluetoothRepository.sendData(device, data);
    } catch (e) {
      throw Exception();
    }
  }
}
