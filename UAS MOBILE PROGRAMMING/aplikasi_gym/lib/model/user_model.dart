import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  String fullName;
  bool profileSetupComplete;
  String gender;
  int age;
  double height;
  double weight;
  String goal;
  String level;
  int currentXp; 
  int maxXp;    

  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.profileSetupComplete,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.level,
    this.currentXp = 0,   
    this.maxXp = 100,      
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? 'Gym Bro',
      profileSetupComplete: data['profileSetupComplete'] ?? false,
      gender: data['gender'] ?? 'male',
      age: (data['age'] as num?)?.toInt() ?? 0,
      height: (data['height'] as num?)?.toDouble() ?? 170.0,
      weight: (data['weight'] as num?)?.toDouble() ?? 60.0,
      goal: data['goal'] ?? 'maintain_weight',
      level: data['level'] ?? 'Beginner',
      currentXp: (data['currentXp'] as num?)?.toInt() ?? 0, 
      maxXp: (data['maxXp'] as num?)?.toInt() ?? 100,       
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'profileSetupComplete': profileSetupComplete,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'goal': goal,
      'level': level,
      'currentXp': currentXp, 
      'maxXp': maxXp,         
    };
  }
}