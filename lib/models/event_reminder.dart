class EventReminder {
  final int? id;
  final int? eventId;
  final int? userId;
  final DateTime reminderTime;
  final String reminderType;
  final DateTime createdAt;

  EventReminder({
    this.id,
    this.eventId,
    this.userId,
    required this.reminderTime,
    required this.reminderType,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'userId': userId,
      'reminderTime': reminderTime.toIso8601String(),
      'reminderType': reminderType,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EventReminder.fromMap(Map<String, dynamic> map) {
    return EventReminder(
      id: map['id'],
      eventId: map['eventId'],
      userId: map['userId'],
      reminderTime: DateTime.parse(map['reminderTime']),
      reminderType: map['reminderType'] ?? 'notification',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
} 