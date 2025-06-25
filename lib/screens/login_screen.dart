// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:daily_planner/main.dart'; // untuk akses 'supabase'
import 'package:daily_planner/utils/helpers.dart';
import 'package:daily_planner/screens/signup_screen.dart';
import 'package:daily_planner/screens/home_screen.dart'; // Kita akan buat ini

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() { _isLoading = true; });

    try {
      // Lakukan login dengan email dan password
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Jika berhasil, arahkan ke HomeScreen
      if (mounted) {
        // pushAndRemoveUntil akan menghapus semua halaman sebelumnya (login, signup)
        // dari tumpukan navigasi, sehingga user tidak bisa kembali ke sana
        // dengan tombol back setelah login.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    } on AuthException catch (error) {
      if (mounted) showErrorSnackBar(context, error.message);
    } catch (error) {
      if (mounted) showErrorSnackBar(context, 'Terjadi kesalahan tidak terduga.');
    }

    setState(() { _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _signIn,
                        child: const Text('Login'),
                      ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text('Belum punya akun? Daftar di sini'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}