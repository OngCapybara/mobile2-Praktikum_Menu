import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;

  const SimplePage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.indigo),
            const SizedBox(height: 12),
            Text(
              'Ini adalah halaman $title',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}