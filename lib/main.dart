import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const KoliTakipApp());
}

class KoliTakipApp extends StatelessWidget {
  const KoliTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koli Takip',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LoginScreen(),
    );
  }
}
