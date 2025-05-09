import 'package:flutter/material.dart';
// Comment out the qr_flutter import until it's available
// import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDisplay extends StatelessWidget {
  final String data;

  const QRCodeDisplay({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Placeholder for QrImageView until the package is available
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Icon(
                Icons.qr_code,
                size: 100,
                color: Colors.black54,
              ),
            ),
          ),
          /* Original QR implementation
          QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(8),
          ),
          */
          const SizedBox(height: 16),
          const Text(
            'Scan this QR code for ticket verification',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
} 