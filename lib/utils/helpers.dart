// lib/utils/helpers.dart

import 'package:flutter/material.dart';
import 'package:daily_planner/utils/app_colors.dart'; // Import palet warna kita

/// Menampilkan notifikasi sukses (SnackBar) yang modern.
void showSuccessSnackBar(BuildContext context, String message) {
  // Hapus notifikasi lama jika masih ada, untuk menghindari tumpukan notifikasi
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.completed, // Warna hijau dari palet kita
      behavior: SnackBarBehavior.floating, // Membuatnya mengambang, tidak menempel di bawah
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
  );
}

/// Menampilkan notifikasi error (SnackBar) yang modern.
void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.accent, // Warna merah dari palet kita
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
  );
}
