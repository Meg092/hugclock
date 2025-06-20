import 'dart:async';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

class TimerMainLogic extends GetxController {
  var txtColor = Colors.white.obs;
  var bgColor = Colors.black.obs;
  var clockStyle = true.obs;

  var hourMinuteStr = '00:00'.obs;
  var secondStr = '00'.obs;
  var apmStr = ''.obs;
  var weekMonthStr = ''.obs;

  var type = 0;
  var isStart = false.obs;
  var downtime = 0;
  var downtimeStr = '00:00'.obs;

  Timer? _timer;
  Timer? _downTimer;

  void startTimer() {
    getTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getTime();
    });
  }

  void startDownTimer() {
    _downTimer?.cancel();
    _downTimer = null;
    isStart.value = true;
    downtimeStr.value =
        '${downtime ~/ 60 < 10 ? '0${downtime ~/ 60}' : '${downtime ~/ 60}'}:${downtime % 60 < 10 ? '0${downtime % 60}' : '${downtime % 60}'}';
    _downTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (downtime > 0) {
        downtime--;
        downtimeStr.value =
            '${downtime ~/ 60 < 10 ? '0${downtime ~/ 60}' : '${downtime ~/ 60}'}:${downtime % 60 < 10 ? '0${downtime % 60}' : '${downtime % 60}'}';
        if (downtime == 0) {
          _downTimer?.cancel();
          _downTimer = null;
          isStart.value = true;
        }
      }
    });
  }

  void stopDownTimer() {
    _downTimer?.cancel();
    _downTimer = null;
    isStart.value = false;
  }

  void getTime() {
    final now = DateTime.now();
    hourMinuteStr.value = DateFormat('HH:mm').format(now);
    secondStr.value = DateFormat('ss').format(now);
    apmStr.value = DateFormat('a').format(now).toUpperCase();
    weekMonthStr.value = DateFormat('EEEE, MMMM d').format(now);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    startTimer();
    super.onInit();
  }

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final txtColorStr = prefs.getString('txtColor') ?? '';
    final bgColorStr = prefs.getString('bgColor') ?? '';
    txtColor.value = txtColorStr.toColor() ?? Colors.white;
    bgColor.value = bgColorStr.toColor() ?? Colors.black;
    clockStyle.value = prefs.getBool('clockStyle') ?? true;
    update();
  }

  void showDiaData() async {
    DateTime currentDownTime = DateTime.now();
    Get.dialog(AlertDialog(
      title: const Text(
        'Set the countdown',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      content: GetBuilder<TimerMainLogic>(
          id: 'downTime',
          builder: (_) {
            return SizedBox(
              height: 190,
              child: <Widget>[
                SizedBox(
                  height: 120,
                  child: DateTimePickerWidget(
                    dateFormat: 'mm:ss',
                    initDateTime: currentDownTime,
                    pickerTheme: const DateTimePickerTheme(
                      showTitle: false,
                      title: null,
                      backgroundColor: Colors.transparent,
                    ),
                    onChange: (dateTime, selectedIndex) {
                      currentDownTime = dateTime;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'Commit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
                    .decorated(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12))
                    .gestures(onTap: () {
                  downtime =
                      currentDownTime.minute * 60 + currentDownTime.second;
                  downtimeStr.value =
                      '${downtime ~/ 60 < 10 ? '0${downtime ~/ 60}' : '${downtime ~/ 60}'}:${downtime % 60 < 10 ? '0${downtime % 60}' : '${downtime % 60}'}';
                  type = 1;
                  stopDownTimer();
                  update(['downTime']);
                  update();
                  Get.back();
                })
              ].toColumn(),
            );
          }),
    ));
  }
}
