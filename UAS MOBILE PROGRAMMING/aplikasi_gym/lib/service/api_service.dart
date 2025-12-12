import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_gym/model/exercise_model.dart';

class ApiService {
  static const String _baseUrl = 'exercisedb.p.rapidapi.com';

 
  static const Map<String, String> headers = {
    'x-rapidapi-host': 'api.api-ninjas.com',
    
    'x-rapidapi-key': 'hOnGCT+JaVHLdrKOkb8dZw==I105VLiaUiRvGMph', 
  };
  
  
  static const List<String> _bodyParts = [
    'back', 'cardio', 'chest', 'lower arms', 'lower legs', 
    'neck', 'shoulders', 'upper arms', 'upper legs', 'waist'
  ];

  Future<List<ExerciseModel>> fetchExercisesByBodyPart(String bodyPart) async {
    
    final uri = Uri.https(
      _baseUrl, 
      '/exercises/bodyPart/$bodyPart', 
      {'limit': '30'} 
    );

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => ExerciseModel.fromJson(item)).toList();
      } else {
       
        throw Exception("Gagal load data. Status: ${response.statusCode}. Cek API Key/Quota.");
      }
    } catch (e) {
     
      throw Exception("Error koneksi: $e");
    }
  }

  
  Future<List<ExerciseModel>> searchExercises(String query) async {
 
    final uri = Uri.https(
      _baseUrl, 
      '/exercises/name/$query', 
      {'limit': '30'}
    );

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => ExerciseModel.fromJson(item)).toList();
      } else {
        return []; 
      }
    } catch (e) {
      throw Exception("Error search: $e");
    }
  }
  

  Future<List<String>> fetchMuscleCategories() async {
    return _bodyParts;
  }
}