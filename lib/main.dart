import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  // Titik awal aplikasi Flutter
  runApp(const JelajahYukApp());
}

class JelajahYukApp extends StatelessWidget {
  const JelajahYukApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JelajahYuk',

      // Mengatur tema utama aplikasi
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087E8B)),
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
        fontFamily: 'Roboto',
      ),

      // Halaman pertama yang ditampilkan adalah Login
      home: const LoginScreen(),
    );
  }
}
