class EventAttachment {
  final int? id;
  final int? eventId;
  final String fileName;
  final String filePath;
  final String fileType;
  final int fileSize;
  final DateTime createdAt;

  EventAttachment({
    this.id,
    this.eventId,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'fileName': fileName,
      'filePath': filePath,
      'fileType': fileType,
      'fileSize': fileSize,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory EventAttachment.fromMap(Map<String, dynamic> map) {
    return EventAttachment(
      id: map['id'],
      eventId: map['eventId'],
      fileName: map['fileName'] ?? '',
      filePath: map['filePath'] ?? '',
      fileType: map['fileType'] ?? '',
      fileSize: map['fileSize'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
} 