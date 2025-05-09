import '../models/event_attachment.dart';

class EventAttachmentRepository {
  // Singleton instance
  static final EventAttachmentRepository _instance = EventAttachmentRepository._internal();
  factory EventAttachmentRepository() => _instance;
  EventAttachmentRepository._internal();

  // Mock data storage
  final List<EventAttachment> _attachments = [];
  bool _isInitialized = false;

  // Initialize mock data
  Future<void> _initialize() async {
    if (_isInitialized) return;
    
    // Add sample attachments
    _attachments.addAll([
      EventAttachment(
        id: 1,
        eventId: 1,
        fileName: 'event_schedule.pdf',
        filePath: '/attachments/event_schedule.pdf',
        fileType: 'application/pdf',
        fileSize: 1024 * 1024, // 1MB
        createdAt: DateTime.now(),
      ),
      EventAttachment(
        id: 2,
        eventId: 1,
        fileName: 'venue_map.jpg',
        filePath: '/attachments/venue_map.jpg',
        fileType: 'image/jpeg',
        fileSize: 512 * 1024, // 512KB
        createdAt: DateTime.now(),
      ),
      EventAttachment(
        id: 3,
        eventId: 2,
        fileName: 'artist_lineup.pdf',
        filePath: '/attachments/artist_lineup.pdf',
        fileType: 'application/pdf',
        fileSize: 2048 * 1024, // 2MB
        createdAt: DateTime.now(),
      ),
    ]);
    
    _isInitialized = true;
    print('Event attachment repository initialized with mock data');
  }

  // Get all attachments
  Future<List<EventAttachment>> getAllAttachments() async {
    await _initialize();
    return List.from(_attachments);
  }

  // Get attachments by event id
  Future<List<EventAttachment>> getAttachmentsByEventId(int eventId) async {
    await _initialize();
    return _attachments.where((a) => a.eventId == eventId).toList();
  }

  // Get attachment by id
  Future<EventAttachment?> getAttachmentById(int id) async {
    await _initialize();
    try {
      return _attachments.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  // Create attachment
  Future<EventAttachment> createAttachment(EventAttachment attachment) async {
    await _initialize();
    
    // Create new attachment
    final newAttachment = EventAttachment(
      id: _attachments.isEmpty ? 1 : _attachments.map((a) => a.id ?? 0).reduce((a, b) => a > b ? a : b) + 1,
      eventId: attachment.eventId,
      fileName: attachment.fileName,
      filePath: attachment.filePath,
      fileType: attachment.fileType,
      fileSize: attachment.fileSize,
      createdAt: DateTime.now(),
    );
    
    _attachments.add(newAttachment);
    return newAttachment;
  }

  // Update attachment
  Future<EventAttachment?> updateAttachment(EventAttachment attachment) async {
    await _initialize();
    
    if (attachment.id == null) {
      throw Exception('Attachment ID is required for update');
    }

    final index = _attachments.indexWhere((a) => a.id == attachment.id);
    if (index == -1) {
      return null;
    }
    
    // Update attachment
    _attachments[index] = attachment;
    return attachment;
  }

  // Delete attachment
  Future<bool> deleteAttachment(int id) async {
    await _initialize();
    
    final initialLength = _attachments.length;
    _attachments.removeWhere((a) => a.id == id);
    
    return _attachments.length < initialLength;
  }
} 