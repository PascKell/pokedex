import 'package:flutter/material.dart';

Color typeColor(String type) {
  switch (type.toLowerCase()) {
    case 'feuer':
      return Colors.red;
    case 'wasser':
      return Colors.blue;
    case 'pflanze':
      return Colors.green;
    case 'elektro':
      return Colors.amber;
    case 'eis':
      return Colors.cyanAccent;
    case 'kampf':
      return Colors.orange;
    case 'gift':
      return Colors.purple;
    case 'boden':
      return Colors.brown;
    case 'flug':
      return Colors.lightBlue;
    case 'psycho':
      return Colors.pink;
    case 'käfer':
      return Colors.lightGreen;
    case 'gestein':
      return Colors.grey;
    case 'geist':
      return Colors.deepPurple;
    case 'drache':
      return Colors.indigo;
    case 'unlicht':
      return Colors.black87;
    case 'stahl':
      return Colors.blueGrey;
    case 'fee':
      return Colors.pinkAccent;
    default:
      return Colors.brown.shade300;
  }
}

LinearGradient typeGradient(String t1, String? t2) {
  return LinearGradient(
    colors: [
      typeColor(t1),
      typeColor(t1),
      typeColor(t2 ?? t1),
      Colors.white,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

LinearGradient detailTypeGradient(String t1, String? t2) {
  return LinearGradient(
    colors: [
      typeColor(t1),
      typeColor(t1),
      typeColor(t2 ?? t1),
      typeColor(t2 ?? t1),
      typeColor(t2 ?? t1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}