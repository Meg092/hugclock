import 'package:clock_timer/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:styled_widget/styled_widget.dart';

import 'timer_main_logic.dart';

class TimerMainPage extends StatefulWidget {
  const TimerMainPage({Key? key}) : super(key: key);

  @override
  State<TimerMainPage> createState() => _TimerMainPageState();
}

class _TimerMainPageState extends State<TimerMainPage> {
  TimerMainLogic controller = Get.find<TimerMainLogic>();

  void checkNetwork() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/local_error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  Widget _buildTimeWidget() {
    return <Widget>[
      <Widget>[
        Text(
          controller.hourMinuteStr.value,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: kTextFamily,
              fontSize: controller.clockStyle.value ? 320 : 240,
              height: 0.8,
              color: controller.txtColor.value),
        ),
        const SizedBox(
          width: 6,
        ),
        <Widget>[
          Obx(() {
            return Visibility(
              visible: !controller.clockStyle.value,
              child: Obx(() {
                return Text(
                  controller.apmStr.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 46,
                      color: controller.txtColor.value),
                );
              }),
            );
          }),
          const SizedBox(
            height: 70,
          ),
          Obx(() {
            return Visibility(
              visible: !controller.clockStyle.value,
              child: Obx(() {
                return Text(
                  controller.secondStr.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: kTextFamily,
                      fontSize: 46,
                      color: controller.txtColor.value),
                );
              }),
            );
          }),
        ].toColumn(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start)
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
      Obx(() {
        return Visibility(
          visible: !controller.clockStyle.value,
          child: Obx(() {
            return Text(
              controller.weekMonthStr.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 46,
                  color: controller.txtColor.value),
            );
          }),
        );
      }),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.center);
  }

  Widget _buildDownTimeWidget() {
    return <Widget>[
      const SizedBox(
        height: 20,
      ),
      Obx(() {
        return Text(
          controller.downtimeStr.value,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: kTextFamily,
              fontSize: 208,
              height: 0.8,
              color: controller.txtColor.value),
        );
      }),
      const SizedBox(
        height: 10,
      ),
      <Widget>[
        Obx(() {
          return Icon(
            controller.isStart.value
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
            size: 44,
            color: controller.txtColor.value,
          ).gestures(onTap: () {
            if (controller.isStart.value) {
              controller.stopDownTimer();
            } else {
              controller.startDownTimer();
            }
          });
        }),
        Obx(() {
          return Text(
            controller.isStart.value ? 'Pause' : 'Start',
            style: TextStyle(color: controller.txtColor.value),
          );
        })
      ].toColumn()
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: controller.bgColor.value,
        body: SafeArea(
            child: <Widget>[
          <Widget>[
            <Widget>[
              Image.asset(
                'assets/icon0.webp',
                fit: BoxFit.cover,
              ).gestures(onTap: () {
                controller.type = 0;
                controller.update();
                controller.stopDownTimer();
              }),
              Image.asset(
                'assets/icon1.webp',
                fit: BoxFit.cover,
              ).marginSymmetric(horizontal: 10).gestures(onTap: () {
                controller.showDiaData();
              }),
              Image.asset(
                'assets/icon2.webp',
                fit: BoxFit.cover,
              ).gestures(onTap: () {
                Get.toNamed('/timerSetting')?.then((_) {
                  controller.getData();
                });
              })
            ].toRow(mainAxisAlignment: MainAxisAlignment.end),
            GetBuilder<TimerMainLogic>(builder: (_) {
              return SizedBox(
                child: controller.type == 0
                    ? _buildTimeWidget()
                    : _buildDownTimeWidget(),
              );
            }),
          ].toColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center)
        ].toStack(alignment: Alignment.center)),
      );
    });
  }
}
