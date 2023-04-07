class Review {
  final String id;
  final String userId;
  final String comment;
  final double rating;
  final DateTime timestamp;

  Review({
    required this.id,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.timestamp,
  });
}
