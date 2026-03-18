class ProjectModel {
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> techStack;

  ProjectModel({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.techStack,
  });
}
