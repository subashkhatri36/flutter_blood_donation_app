import 'package:flutter_blood_donation_app/app/core/model/user_models.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  List<UserModel> user = [
    UserModel(
      userId: 'sfs',
      phoneNo: '12323',
      username: 'Ram',
      active: true,
      bloodgroup: '',
      email: '',
      latitude: 0.0,
      longitude: 0.0,
      userAddress: '',
      photoUrl: 'https://wallpaperaccess.com/full/2213424.jpg',
    ),
    UserModel(
      userId: 'sfas',
      phoneNo: '12323',
      username: 'Sita',
      active: false,
      bloodgroup: '',
      email: '',
      latitude: 23,
      longitude: 77,
      userAddress: 'B',
      photoUrl:
          'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    ),
    UserModel(
      userId: 'sf',
      phoneNo: '12323',
      username: 'Hari',
      active: true,
      bloodgroup: 'A',
      email: '',
      latitude: 0.0,
      longitude: 0.0,
      userAddress: '',
      photoUrl:
          'https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
    ),
    UserModel(
      userId: 'sf',
      phoneNo: '12323',
      username: 'Ramesh',
      active: true,
      bloodgroup: 'AB +',
      email: '',
      latitude: 0.0,
      longitude: 0.0,
      userAddress: '',
      photoUrl:
          'https://expertphotography.com/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg',
    ),
    UserModel(
      userId: 'sf',
      phoneNo: '12323',
      username: 'Shyam',
      active: true,
      bloodgroup: 'AB -',
      email: '',
      latitude: 0.0,
      longitude: 0.0,
      userAddress: '',
      photoUrl: 'https://i.stack.imgur.com/HILmr.png',
    ),
  ];

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
