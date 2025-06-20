import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerSettingLogic extends GetxController {

  var txtColor = Colors.white.obs;
  var bgColor = Colors.black.obs;
  var clockStyle = true.obs;
  var versionStr = 'v1.0.0'.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final txtColorStr = prefs.getString('txtColor') ?? '';
    final bgColorStr = prefs.getString('bgColor') ?? '';
    txtColor.value = txtColorStr.toColor() ?? Colors.white;
    bgColor.value = bgColorStr.toColor() ?? Colors.black;
    clockStyle.value = prefs.getBool('clockStyle') ?? true;
    var info = await PackageInfo.fromPlatform();
    versionStr.value = 'v${info.version}';
    super.onInit();
  }

}
