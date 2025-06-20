import 'package:get/get.dart';

import 'local_error_logic.dart';

class LocalErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoNetworkLogic());
  }
}
