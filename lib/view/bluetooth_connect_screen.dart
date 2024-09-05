import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcc/controller/bluetooth_connect_controller.dart';
import 'package:rcc/core/component/connect_widget.dart';
import 'package:rcc/core/component/result_widget.dart';
import 'package:rcc/view/connect_screen.dart';

class BluetoothConnectScreen extends GetView<BluetoothConnectController> {
  const BluetoothConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => FloatingActionButton.extended(
          onPressed: controller.fabAction,
          label: (controller.status == Status.loading)
              ? const Text('Stop')
              : const Text('Scan'),
          icon: (controller.status == Status.loading)
              ? const Icon(Icons.square)
              : const Icon(Icons.search),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBodyBehindAppBar: true,
    );
  }

  Widget _home() {
    return SafeArea(
      child: ListView(
        children: [
          _already(),
          _result(),
        ],
      ),
    );
  }

  Widget _already() {
    return (controller.already.isEmpty)
        ? Container()
        : Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Connect LED\'s',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.already.length,
                  itemBuilder: (context, index) {
                    final connect = controller.already[index];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConnectWidget(
                          data: connect,
                          disconnect: (_) {
                            controller.disconnect(connect);
                          },
                          move: () {
                            if (!connect.isConnected) {
                              return;
                            }
                            Get.to(() => ConnectScreen(
                                  deviceModel: connect,
                                ));
                          },
                        ));
                  }),
            ],
          );
  }

  Widget _result() {
    return (controller.result.isEmpty)
        ? Text(
            "No Result",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        : Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Available LED\'s',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.result.length,
                itemBuilder: (context, index) {
                  final data = controller.result[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ResultWidget(
                        data: data,
                        remove: (_) {
                          controller.removeDevice(index);
                        },
                        connect: (_) {
                          controller.connectDevice(data);
                        },
                        move: () {
                          if (!data.isConnected) {
                            return;
                          }
                          Get.to(() => ConnectScreen(
                                deviceModel: data,
                              ));
                        },
                      ));
                },
              ),
            ],
          );
  }
}
