import 'package:get/get.dart';

class HomeController extends GetxController {
  
  
  var userName = "Memuat...".obs;
  var userLevel = "Beginner".obs;
  
  
  var currentXp = 0.obs;
  var maxXp = 100.obs;
  
  @override
  void onInit() {
  
    fetchUserData(); 
    super.onInit();
  }

  void fetchUserData() async {
    
    await Future.delayed(const Duration(milliseconds: 500)); 
 
    userName.value = "John Doe"; 
    userLevel.value = "Intermediate";
    currentXp.value = 75;
    maxXp.value = 150;
  }
}