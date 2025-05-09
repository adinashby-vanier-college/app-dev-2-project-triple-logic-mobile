class EventParticipant {
  final int? id;
  final int? eventId;
  final int? userId;
  final String status;
  final DateTime createdAt;

  EventParticipant({
    this.id,
    this.eventId,
    this.userId,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'userId': userId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EventParticipant.fromMap(Map<String, dynamic> map) {
    return EventParticipant(
      id: map['id'],
      eventId: map['eventId'],
      userId: map['userId'],
      status: map['status'] ?? 'registered',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
} 