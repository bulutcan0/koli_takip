import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key}); // 🔥 const constructor tanımladık

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Scan Screen')), // örnek
    );
  }
}
