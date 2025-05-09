class Ticket {
  final int? id;
  final int eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final String ticketType;
  final double price;
  final DateTime purchaseDate;
  final String? qrCode;

  Ticket({
    this.id,
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.ticketType,
    required this.price,
    DateTime? purchaseDate,
    this.qrCode,
  }) : purchaseDate = purchaseDate ?? DateTime.now();

  // Convert Ticket instance to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'event_id': eventId,
      'event_name': eventName,
      'event_date': eventDate,
      'event_time': eventTime,
      'event_location': eventLocation,
      'ticket_type': ticketType,
      'price': price,
      'purchase_date': purchaseDate.toIso8601String(),
      'qr_code': qrCode,
    };
  }

  // Create Ticket instance from a Map (database result)
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      eventId: map['event_id'],
      eventName: map['event_name'],
      eventDate: map['event_date'],
      eventTime: map['event_time'],
      eventLocation: map['event_location'],
      ticketType: map['ticket_type'],
      price: map['price'] is int 
          ? (map['price'] as int).toDouble() 
          : map['price'] ?? 0.0,
      purchaseDate: map['purchase_date'] != null 
          ? DateTime.parse(map['purchase_date']) 
          : null,
      qrCode: map['qr_code'],
    );
  }
} 