import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase Configuration Placeholders
  // Replace these with your actual Supabase URL and Anon Key
  const String supabaseUrl = 'https://YOUR_PROJECT_ID.supabase.co';
  const String supabaseAnonKey = 'YOUR_ANON_KEY';

  bool isSupabaseInitialized = false;

  if (supabaseUrl != 'https://YOUR_PROJECT_ID.supabase.co' && supabaseAnonKey != 'YOUR_ANON_KEY') {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      isSupabaseInitialized = true;
    } catch (e) {
      debugPrint('Error inisialisasi Supabase: $e');
    }
  } else {
    debugPrint('Supabase menggunakan kredensial placeholder. Mode simulasi diaktifkan.');
  }

  runApp(MyApp(isSupabaseInitialized: isSupabaseInitialized));
}

class MyApp extends StatelessWidget {
  final bool isSupabaseInitialized;

  const MyApp({super.key, required this.isSupabaseInitialized});

  @override
  Widget build(BuildContext context) {
    // Check if session exists in Supabase
    Widget initialScreen = const SplashScreen();
    
    if (isSupabaseInitialized) {
      try {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          initialScreen = const MainNavigationPage();
        }
      } catch (e) {
        debugPrint('Error memvalidasi sesi Supabase: $e');
      }
    }

    return MaterialApp(
      title: 'BooyahHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDF8F2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF2C94C),
          primary: const Color(0xFFF2C94C),
          secondary: const Color(0xFF1E1B18),
          surface: const Color(0xFFFDF8F2),
        ),
      ),
      home: initialScreen,
    );
  }
}
