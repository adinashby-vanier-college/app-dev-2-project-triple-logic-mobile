import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/event_details_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/digital_ticket_screen.dart';
import 'screens/admin_login_screen.dart';
import 'models/user.dart';
import 'models/event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '24BITS Events',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          titleMedium: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return LoginScreen(prefilledEmail: args?['email']);
        },
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
        '/admin-login': (context) => const AdminLoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/event-details') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => EventDetailsScreen(
              event: Event(
                id: args['id'],
                name: args['eventName'] ?? '',
                date: args['eventDate'] ?? '',
                time: args['eventTime'] ?? '',
                location: args['eventLocation'] ?? '',
                imageUrl: args['imageUrl'],
                description: args['description'] ?? 'No description available.',
                category: args['category'] ?? 'Event',
                price: args['price'] is int ? (args['price'] as int).toDouble() : args['price'] ?? 0.0,
                vipPrice: args['vipPrice'] is int ? (args['vipPrice'] as int).toDouble() : args['vipPrice'],
                multiDayPrice: args['multiDayPrice'] is int ? (args['multiDayPrice'] as int).toDouble() : args['multiDayPrice'],
                createdBy: args['createdBy'] ?? 1,
                createdAt: args['createdAt'] != null ? DateTime.parse(args['createdAt']) : null,
              ),
            ),
          );
        } else if (settings.name == '/checkout') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CheckoutScreen(
              eventName: args['eventName'],
              eventDate: args['eventDate'],
              eventLocation: args['eventLocation'],
              ticketType: args['ticketType'],
              ticketPrice: args['ticketPrice'],
            ),
          );
        } else if (settings.name == '/ticket') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DigitalTicketScreen(
              eventName: args['eventName'],
              eventDate: args['eventDate'],
              eventTime: args['eventTime'],
              eventLocation: args['eventLocation'],
              ticketType: args['ticketType'],
              price: args['price'],
            ),
          );
        }
        return null;
      },
    );
  }
}
