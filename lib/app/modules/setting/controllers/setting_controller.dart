import 'package:get/get.dart';

class SettingController extends GetxController {
  RxDouble minkilo = 10.0.obs;
  RxDouble maxkilo = 20.0.obs;

  final shownotification = true.obs;
  set shownotification(value) => this.shownotification.value = value;
  get notification => this.shownotification.value;
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
}

