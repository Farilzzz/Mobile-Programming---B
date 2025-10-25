class BodyPart {
  final String name;
  final String imagePath;
  final List<Exercise> exercises;

  BodyPart({
    required this.name,
    required this.imagePath,
    required this.exercises,
  });

  factory BodyPart.fromJson(Map<String, dynamic> json) {
    var exList = json['exercises'] as List;
    List<Exercise> exercises = exList.map((i) => Exercise.fromJson(i)).toList();

    return BodyPart(
      name: json['name'],
      imagePath: json['imagePath'],
      exercises: exercises,
    );
  }
}

class Exercise {
  final String name;
  final String imagePath;
  final String info; // "Press Info"
  final String description;
  final String targetMuscles;
  final String preparation;

  Exercise({
    required this.name,
    required this.imagePath,
    required this.info,
    required this.description,
    required this.targetMuscles,
    required this.preparation,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      imagePath: json['imagePath'],
      info: json['info'],
      description: json['description'],
      targetMuscles: json['targetMuscles'],
      preparation: json['preparation'],
    );
  }
}
