
import 'package:flutter/material.dart';

Widget bottomNavigationBarItem(Function onItemTapped, IconData icon,
    String label, Color color, int index) {
  return GestureDetector(
    onTap: () => onItemTapped(index),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Text(label,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: color,
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
  );
}