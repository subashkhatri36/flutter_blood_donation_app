import 'package:get/get.dart';

class RequestController extends GetxController {
  //TODO: Implement RequestController
var isSwitched=false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
