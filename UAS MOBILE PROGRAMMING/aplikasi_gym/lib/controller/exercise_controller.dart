import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:translator/translator.dart';
import 'package:aplikasi_gym/model/exercise_model.dart';

class ExerciseController extends GetxController {
  var isLoading = true.obs;
 
  var isSearching = false.obs;

  var exerciseList = <ExerciseModel>[].obs;
  var filteredList = <ExerciseModel>[].obs;

  final translator = GoogleTranslator();

  
  final String apiKey = 'hOnGCT+JaVHLdrKOkb8dZw==I105VLiaUiRvGMph';

  void fetchExercises(String categoryUI) async {
    try {
      isLoading(true);

      String targetMuscle = _mapMuscleName(categoryUI);
      var url = Uri.parse(
        'https://api.api-ninjas.com/v1/exercises?muscle=$targetMuscle',
      );

      print("Request ke API Ninjas: $targetMuscle");

      var response = await http.get(url, headers: {'X-Api-Key': apiKey});

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        var data = jsonData.map((e) => ExerciseModel.fromJson(e)).toList();

         for (var item in data) {
          try {
             var translation = await translator.translate(item.instructions, to: 'id');
             item.instructions = translation.text;
          } catch (e) {
          
            print("Skip translate");
          }
        } 

        exerciseList.assignAll(data);
        filteredList.assignAll(data);
      } else {
        Get.snackbar("Gagal", "Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Koneksi", "Cek internet kamu.");
    } finally {
      isLoading(false);
    }
  }


  void runFilter(String enteredKeyword) async {

    isSearching.value = true;

   
    await Future.delayed(const Duration(seconds: 2));

    if (enteredKeyword.isEmpty) {
      filteredList.assignAll(exerciseList);
    } else {
      filteredList.assignAll(
        exerciseList
            .where(
              (exercise) => exercise.name.toLowerCase().contains(
                enteredKeyword.toLowerCase(),
              ),
            )
            .toList(),
      );
    }

   
    isSearching.value = false;
  }

  String _mapMuscleName(String uiName) {
    switch (uiName.toLowerCase()) {
      case 'chest':
        return 'chest';
      case 'biceps':
        return 'biceps';
      case 'triceps':
        return 'triceps';
      case 'abdominals':
        return 'abdominals';
      case 'lats':
        return 'lats';
      case 'back':
        return 'middle_back';
      case 'legs':
        return 'quadriceps';
      case 'shoulders':
        return 'traps';
      case 'calves':
        return 'calves';
      default:
        return 'chest';
    }
  }

  String getImageAsset(String muscle) {
    switch (muscle.toLowerCase()) {
      case 'chest':
        return 'assets/images/chest.png';
      case 'back':
        return 'assets/images/back.png';
      case 'biceps':
        return 'assets/images/biceps.png';
      case 'triceps':
        return 'assets/images/triceps.png';
      case 'legs':
        return 'assets/images/legs.jpg';
      case 'calves':
        return 'assets/images/legs.jpg';
      case 'abdominals':
        return 'assets/images/abs.jpg';
      case 'shoulders':
        return 'assets/images/shoulders.png';
      default:
        return 'assets/images/gym_logo.png';
    }
  }
}
