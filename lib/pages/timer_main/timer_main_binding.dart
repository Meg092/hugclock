import 'package:get/get.dart';

import 'timer_main_logic.dart';

class TimerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimerMainLogic());
  }
}
