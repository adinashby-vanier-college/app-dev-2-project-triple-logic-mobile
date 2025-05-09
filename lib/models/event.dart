class Event {
  final int? id;
  String name;
  String date;
  String time;
  String location;
  String? imageUrl;
  String description;
  String category;
  double price;
  double? vipPrice;
  double? multiDayPrice;
  final int createdBy;
  final DateTime createdAt;

  Event({
    this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
    this.imageUrl,
    required this.description,
    required this.category,
    required this.price,
    this.vipPrice,
    this.multiDayPrice,
    required this.createdBy,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert Event instance to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'time': time,
      'location': location,
      'image_url': imageUrl,
      'description': description,
      'category': category,
      'price': price,
      'vip_price': vipPrice,
      'multi_day_price': multiDayPrice,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Create Event instance from a Map (database result)
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      imageUrl: map['image_url'],
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price'] is int 
          ? (map['price'] as int).toDouble() 
          : map['price'] ?? 0.0,
      vipPrice: map['vip_price'] is int 
          ? (map['vip_price'] as int).toDouble() 
          : map['vip_price'],
      multiDayPrice: map['multi_day_price'] is int 
          ? (map['multi_day_price'] as int).toDouble() 
          : map['multi_day_price'],
      createdBy: map['created_by'] ?? 1,
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at']) 
          : null,
    );
  }

  // Create a copy of this Event with given fields replaced with new values
  Event copyWith({
    int? id,
    String? name,
    String? date,
    String? time,
    String? location,
    String? imageUrl,
    String? description,
    String? category,
    double? price,
    double? vipPrice,
    double? multiDayPrice,
    int? createdBy,
    DateTime? createdAt,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      vipPrice: vipPrice ?? this.vipPrice,
      multiDayPrice: multiDayPrice ?? this.multiDayPrice,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 