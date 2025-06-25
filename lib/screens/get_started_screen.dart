// lib/screens/get_started_screen.dart

import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.task_alt, size: 120, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Daily Planner',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Atur semua rencanamu dan jangan sampai ada yang terlewat!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Tombol lebar
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  // 1. Simpan status bahwa user sudah melewati Get Started Screen
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('showLogin', true);

                  // 2. Arahkan ke halaman login dan hapus halaman ini dari tumpukan
                  // agar tidak bisa kembali dengan tombol back.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Get Started'),
              )
            ],
          ),
        ),
      ),
    );
  }
}