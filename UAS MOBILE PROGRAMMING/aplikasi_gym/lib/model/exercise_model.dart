class ExerciseModel {
  String name;           
  String muscle;
  String equipment;
  String difficulty;
  String instructions;   

  ExerciseModel({
    required this.name,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      name: json['name'] ?? "Unknown Exercise",
      muscle: json['muscle'] ?? "General",
      equipment: json['equipment'] ?? "None",
      difficulty: json['difficulty'] ?? "Unknown",
      instructions: json['instructions'] ?? "No instructions provided.",
    );
  }
}