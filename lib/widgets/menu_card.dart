import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuCard extends StatelessWidget {
  final MenuItem item;

  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item.page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 40, color: Colors.indigo),
            const SizedBox(height: 12),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}