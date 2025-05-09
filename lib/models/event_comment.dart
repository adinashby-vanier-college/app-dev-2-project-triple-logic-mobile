class EventComment {
  final int? id;
  final int? eventId;
  final int? userId;
  final String comment;
  final DateTime createdAt;

  EventComment({
    this.id,
    this.eventId,
    this.userId,
    required this.comment,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'userId': userId,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EventComment.fromMap(Map<String, dynamic> map) {
    return EventComment(
      id: map['id'],
      eventId: map['eventId'],
      userId: map['userId'],
      comment: map['comment'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
} 