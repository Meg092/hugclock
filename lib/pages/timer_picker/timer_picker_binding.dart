import 'package:get/get.dart';

import 'timer_picker_logic.dart';

class TimerPickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
