class ProjectModel {
  final String title;
  final String description;
  final String image;
  final List<String> technologies;
  final String githubUrl;
  final String liveUrl;

  ProjectModel({
    required this.title,
    required this.description,
    required this.image,
    required this.technologies,
    required this.githubUrl,
    required this.liveUrl,
  });
}
