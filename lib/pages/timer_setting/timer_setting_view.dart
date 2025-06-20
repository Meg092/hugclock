import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'timer_setting_logic.dart';

class TimerSettingPage extends GetView<TimerSettingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                <Widget>[
                  Obx(() {
                    return Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          color: controller.bgColor.value,
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: Colors.white, width: 2)),
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Background Color',
                    style: TextStyle(color: Colors.white),
                  )
                ].toRow(),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return ColorPicker(
                      pickerColor: controller.bgColor.value,
                      colorPickerWidth: 300,
                      onColorChanged: (v) async {
                        controller.bgColor.value = v;
                        final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('bgColor', v.toHexString());
                      });
                }),
                const SizedBox(
                  height: 10,
                ),
                <Widget>[
                  Obx(() {
                    return Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          color: controller.txtColor.value,
                          borderRadius: BorderRadius.circular(11)),
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Text Color',
                    style: TextStyle(color: Colors.white),
                  )
                ].toRow(),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return ColorPicker(
                      pickerColor: controller.txtColor.value,
                      colorPickerWidth: 300,
                      onColorChanged: (v) async {
                        controller.txtColor.value = v;
                        final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('txtColor', v.toHexString());
                      });
                }),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 53,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: <Widget>[
                    const Text(
                      'Large clock mode',
                      style: TextStyle(color: Colors.white),
                    ),
                    Obx(() {
                      return Switch(
                          value: controller.clockStyle.value,
                          activeTrackColor: Colors.green,
                          onChanged: (v) async {
                            controller.clockStyle.value = v;
                            final SharedPreferences prefs = await SharedPreferences
                                .getInstance();
                            prefs.setBool('clockStyle', v);
                          });
                    })
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ).decorated(
                    color: const Color(0xff414141),
                    borderRadius: BorderRadius.circular(12)),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 53,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: <Widget>[
                    const Text(
                      'Version info',
                      style: TextStyle(color: Colors.white),
                    ),
                    Obx(() {
                      return Text(controller.versionStr.value,
                        style: const TextStyle(color: Colors.white),);
                    })
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ).decorated(
                    color: const Color(0xff414141),
                    borderRadius: BorderRadius.circular(12))
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ).marginAll(15)),
      ),
    );
  }
}
