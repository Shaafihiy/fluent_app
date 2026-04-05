class Course {
  final String id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double duration; // in hours
  final double rating;
  final int enrollments;
  final String instructor;
  final String imageUrl;
  final String level;
  final List<String> tags;
  final bool isFeatured;
  final bool isRecentlyViewed;
  final double? progress; // 0.0 - 1.0, null if not started

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.duration,
    required this.rating,
    required this.enrollments,
    required this.instructor,
    required this.imageUrl,
    required this.level,
    required this.tags,
    this.isFeatured = false,
    this.isRecentlyViewed = false,
    this.progress,
  });

  String get shortDescription {
    if (description.length <= 120) return description;
    return '${description.substring(0, 120)}...';
  }

  String get formattedPrice {
    if (price == 0) return 'Free';
    return '\$${price.toStringAsFixed(2)}';
  }

  String get formattedDuration {
    final hours = duration.floor();
    final minutes = ((duration - hours) * 60).round();
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }

  String get formattedEnrollments {
    if (enrollments >= 1000) {
      return '${(enrollments / 1000).toStringAsFixed(1)}k';
    }
    return enrollments.toString();
  }
}
