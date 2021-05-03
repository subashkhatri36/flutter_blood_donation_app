import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustommapController extends GetxController {
  var marker = List<Marker>.empty(growable: true).obs;
  var mapmarker = Set.from([]);
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
