import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Widget page;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.page,
  });
}