import 'package:flutter/material.dart';
import '../widgets/qr_code_display.dart'; // Import the QR display widget

class DigitalTicketScreen extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventLocation;
  final String ticketType;
  final double price;

  const DigitalTicketScreen({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.ticketType,
    required this.price,
  });

  String _generateQRData() {
    return 'EVENT:$eventName|DATE:$eventDate|TIME:$eventTime|LOCATION:$eventLocation|TYPE:$ticketType|PRICE:$price';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Ticket'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8),
                        Text(eventDate),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time),
                        const SizedBox(width: 8),
                        Text(eventTime),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 8),
                        Expanded(child: Text(eventLocation)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ticket Type: $ticketType',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: \$${price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: QRCodeDisplay(
                data: _generateQRData(),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Present this QR code at the event entrance',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 