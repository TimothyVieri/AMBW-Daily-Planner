// lib/screens/splash_screen.dart (Dengan Jeda)

import 'package:daily_planner/screens/get_started_screen.dart';
import 'package:daily_planner/screens/home_screen.dart';
import 'package:daily_planner/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_planner/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _redirect();
    });
  }

  Future<void> _redirect() async {
    // === TAMBAHKAN BARIS INI UNTUK MEMBERI JEDA ===
    // Beri waktu 1 detik agar splash screen terlihat.
    await Future.delayed(const Duration(seconds: 1));
    // ============================================

    // Pindahkan pengecekan 'mounted' setelah 'await' untuk keamanan
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final showLogin = prefs.getBool('showLogin') ?? false;

    final session = supabase.auth.currentSession;

    if (!showLogin) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const GetStartedScreen()),
      );
    } else if (session != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}