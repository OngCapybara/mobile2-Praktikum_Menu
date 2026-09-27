import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.school,
                        size: 55,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Portal Akademik Kampus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Portal Kampus',
                applicationVersion: '2.0.0',
              );
            },
          ),
        ],
      ),
    );
  }
}