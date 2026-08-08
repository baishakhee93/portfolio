class ProjectModel {
  final String title;
  final String description;
  final String? imageUrl;
  final List<String>? screenshots;
  final List<String> techStack;
  final bool isFeatured;
  final String? githubUrl;
  final String? playStoreUrl;
  final String? demoUrl;
  final String? role;
  final List<String>? features;
  final String? challenge;
  final String? result;

  ProjectModel({
    required this.title,
    required this.description,
    this.imageUrl,
    this.screenshots,
    required this.techStack,
    this.isFeatured = false,
    this.githubUrl,
    this.playStoreUrl,
    this.demoUrl,
    this.role,
    this.features,
    this.challenge,
    this.result,
  });
}
