class ProjectModel {
  final int id;
  final String title;
  final String description;
  final String? mainImageUrl; // يمكن أن تكون فارغة
  final List<String> galleryImageUrls; // قائمة URLs (قد تكون فارغة)
  final List<String> technologies; // قائمة التقنيات
  final String? githubUrl; // يمكن أن تكون فارغة
  final String? liveUrl; // يمكن أن تكون فارغة
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    this.mainImageUrl,
    required this.galleryImageUrls,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.createdAt,
    this.updatedAt,
  });

  // ✅ منشئ يحول Map إلى ProjectModel
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      mainImageUrl: (map['main_image_url'] as String?)?.trim(),
      galleryImageUrls: _parseStringList(map['gallery_image_urls']),
      technologies: _parseStringList(map['technologies']),
      githubUrl: (map['github_url'] as String?)?.trim(),
      liveUrl: (map['live_url'] as String?)?.trim(),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : null,
    );
  }

  // دالة مساعدة لتحويل الـ List<dynamic> إلى List<String>
  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .where((item) => item != null)
          .map((item) => item.toString().trim())
          .toList();
    }
    if (value is String) {
      try {
        // في حالات نادرة، قد تأتي كنص (مثل "{'item1','item2'}")
        return value
            .replaceAll(RegExp(r'[\{\}"]'), '')
            .split(',')
            .where((s) => s.trim().isNotEmpty)
            .map((s) => s.trim())
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // ✅ تحويل الكائن إلى Map (مفيد عند التحديث)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'main_image_url': mainImageUrl,
      'gallery_image_urls': galleryImageUrls,
      'technologies': technologies,
      'github_url': githubUrl,
      'live_url': liveUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, title: $title, description: $description, mainImageUrl: $mainImageUrl, galleryImageUrls: $galleryImageUrls, technologies: $technologies, githubUrl: $githubUrl, liveUrl: $liveUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.mainImageUrl == mainImageUrl &&
        listEquals(other.galleryImageUrls, galleryImageUrls) &&
        listEquals(other.technologies, technologies) &&
        other.githubUrl == githubUrl &&
        other.liveUrl == liveUrl &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        mainImageUrl.hashCode ^
        galleryImageUrls.hashCode ^
        technologies.hashCode ^
        githubUrl.hashCode ^
        liveUrl.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

// دالة مساعدة للمقارنة بين القوائم
bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null) return false;
  if (a.length != b.length) return false;
  for (int index = 0; index < a.length; index++) {
    if (a[index] != b[index]) return false;
  }
  return true;
}
