import 'package:get/get.dart';

import 'timer_setting_logic.dart';

class TimerSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimerSettingLogic());
  }
}
