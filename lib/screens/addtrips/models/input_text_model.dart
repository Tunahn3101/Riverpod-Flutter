class InputTextModel {
  String name;
  String description;
  String location;
  String gender;
  String? imagePath;

  InputTextModel({
    required this.name,
    required this.description,
    required this.location,
    required this.gender,
    this.imagePath,
  });
}
