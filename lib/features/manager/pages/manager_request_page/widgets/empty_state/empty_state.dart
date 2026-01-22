import 'package:flutter/material.dart';

Widget buildEmptyState({
  required IconData icon,
  required String title,
  required String message,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 48),
    child: Column(
      children: [
        Icon(icon, size: 48, color: const Color(0xFFCBD5E1)),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
        ),
      ],
    ),
  );
}
