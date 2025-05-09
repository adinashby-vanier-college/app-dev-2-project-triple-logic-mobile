import '../models/event_comment.dart';

class EventCommentRepository {
  // Singleton instance
  static final EventCommentRepository _instance = EventCommentRepository._internal();
  factory EventCommentRepository() => _instance;
  EventCommentRepository._internal();

  // Mock data storage
  final List<EventComment> _comments = [];
  bool _isInitialized = false;

  // Initialize mock data
  Future<void> _initialize() async {
    if (_isInitialized) return;
    
    // Add sample comments
    _comments.addAll([
      EventComment(
        id: 1,
        eventId: 1,
        userId: 2,
        comment: 'Looking forward to this event!',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      EventComment(
        id: 2,
        eventId: 1,
        userId: 3,
        comment: 'Can\'t wait to attend. Is there a dress code?',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      EventComment(
        id: 3,
        eventId: 2,
        userId: 2,
        comment: 'I enjoyed last year\'s event. Hope this one is even better!',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ]);
    
    _isInitialized = true;
    print('Event comment repository initialized with mock data');
  }

  // Get all comments
  Future<List<EventComment>> getAllComments() async {
    await _initialize();
    return List.from(_comments);
  }

  // Get comments by event id
  Future<List<EventComment>> getCommentsByEventId(int eventId) async {
    await _initialize();
    return _comments.where((c) => c.eventId == eventId).toList();
  }

  // Get comments by user id
  Future<List<EventComment>> getCommentsByUserId(int userId) async {
    await _initialize();
    return _comments.where((c) => c.userId == userId).toList();
  }

  // Get comment by id
  Future<EventComment?> getCommentById(int id) async {
    await _initialize();
    try {
      return _comments.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // Create comment
  Future<EventComment> createComment(EventComment comment) async {
    await _initialize();
    
    // Create new comment
    final newComment = EventComment(
      id: _comments.isEmpty ? 1 : _comments.map((c) => c.id ?? 0).reduce((a, b) => a > b ? a : b) + 1,
      eventId: comment.eventId,
      userId: comment.userId,
      comment: comment.comment,
      createdAt: DateTime.now(),
    );
    
    _comments.add(newComment);
    return newComment;
  }

  // Update comment
  Future<EventComment?> updateComment(EventComment comment) async {
    await _initialize();
    
    if (comment.id == null) {
      throw Exception('Comment ID is required for update');
    }

    final index = _comments.indexWhere((c) => c.id == comment.id);
    if (index == -1) {
      return null;
    }
    
    // Update comment
    _comments[index] = comment;
    return comment;
  }

  // Delete comment
  Future<bool> deleteComment(int id) async {
    await _initialize();
    
    final initialLength = _comments.length;
    _comments.removeWhere((c) => c.id == id);
    
    return _comments.length < initialLength;
  }
} 