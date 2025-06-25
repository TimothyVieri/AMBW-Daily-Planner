// lib/main.dart

import 'package:daily_planner/screens/splash_screen.dart'; // Import SplashScreen
import 'package:daily_planner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kxcrqnskzldsjjknwddh.supabase.co', // URL Supabase-mu
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt4Y3JxbnNremxkc2pqa253ZGRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA4NTI2OTUsImV4cCI6MjA2NjQyODY5NX0.P7p2tPVIW8gVElAKgBez7ENGVpCS2TfWuX5zciHBuV8', // Anon Key-mu
  );

  runApp(const MyApp());
}

// Helper Supabase tetap di sini agar bisa diakses global
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Planner',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        // Terapkan Font Profesional ke seluruh aplikasi
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0.5,
          titleTextStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}