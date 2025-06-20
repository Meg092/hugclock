import 'package:get/get.dart';

import 'timer_picker_logic.dart';

class AppMjhsndBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
