// lib/screens/signup_screen.dart

import 'package:daily_planner/main.dart';
import 'package:daily_planner/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  Future<void> _signUp() async {
    // 1. Validasi input
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() { _isLoading = true; });

    try {
      // 2. Lakukan registrasi
      await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 3. Tampilkan pesan sukses dan kembali ke halaman login
      if (mounted) {
        showSuccessSnackBar(context, 'Registrasi berhasil! Silakan login.');
        Navigator.pop(context); // Kembali ke halaman login
      }
    } on AuthException catch (error) {
      // Tangani error, misal email sudah terdaftar
      if (mounted) {
        showErrorSnackBar(context, error.message);
      }
    } catch (error) {
      // Tangani error umum
      if (mounted) {
        showErrorSnackBar(context, 'Terjadi kesalahan tidak terduga.');
      }
    }

    setState(() { _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email field
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
                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password minimal harus 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Tombol Sign Up
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text('Sign Up'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}