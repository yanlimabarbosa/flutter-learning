class Course {
  const Course({
    required this.id,
    required this.documentId,
    required this.title,
    required this.slug,
    required this.description,
    required this.level,
    required this.durationMinutes,
  });

  final int id;
  final String documentId;
  final String title;
  final String slug;
  final String description;
  final String level;
  final int durationMinutes;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      documentId: json['documentId'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      durationMinutes: json['durationMinutes'] as int,
    );
  }
}
