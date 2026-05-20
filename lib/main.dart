import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/main_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lcstosnlsssgrjeonyjc.supabase.co',
    anonKey: 'sb_publishable_xuvJQ7hFOWd20WJmo5jAIw_ty7YQG_j',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BooyahHub',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: session != null
          ? const MainNavigationPage()
          : const SplashScreen(),
    );
  }
}