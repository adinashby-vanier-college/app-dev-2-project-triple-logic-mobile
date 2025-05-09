import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'admin_login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic structure matching the mockup
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to 24 BIT'),
         backgroundColor: Colors.blue,
         foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Logo with border radius and shadow
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.wifi_tethering,
                  size: 60.0,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '24BITS Events',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Your gateway to live events and experience',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Get Started'),
                onPressed: () {
                  // Navigate to Registration Screen using named route
                  Navigator.pushNamed(context, '/register');
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'or',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextButton(
                child: const Text(
                  'log in',
                   style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  // Navigate to Login Screen using named route
                  Navigator.pushNamed(context, '/login');
                },
              ),
              // Divider and Admin section
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.admin_panel_settings, color: Colors.grey, size: 16),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      // Navigate directly to the admin login screen
                      Navigator.pushNamed(context, '/admin-login');
                    },
                    child: const Text(
                      'Admin Access',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 