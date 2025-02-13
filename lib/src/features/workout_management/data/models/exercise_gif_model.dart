class ExerciseGifModel {
  final String? bodyPart;
  final String? equipment;
  final String? gifUrl;
  final String? id;
  final String? name;
  final String? target;
  final List<String>? secondaryMuscles;
  final List<String>? instructions;

  ExerciseGifModel({
    this.bodyPart,
    this.equipment,
    this.gifUrl,
    this.id,
    this.name,
    this.target,
    this.secondaryMuscles,
    this.instructions,
  });

  factory ExerciseGifModel.fromJson(Map<String, dynamic> json) {
    return ExerciseGifModel(
      bodyPart: json['bodyPart'],
      equipment: json['equipment'],
      gifUrl: json['gifUrl'],
      id: json['id'],
      name: json['name'],
      target: json['target'],
      secondaryMuscles: List<String>.from(json['secondaryMuscles']),
      instructions: List<String>.from(json['instructions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bodyPart': bodyPart,
      'equipment': equipment,
      'gifUrl': gifUrl,
      'id': id,
      'name': name,
      'target': target,
      'secondaryMuscles': secondaryMuscles,
      'instructions': instructions,
    };
  }
}
