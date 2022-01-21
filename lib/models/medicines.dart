import 'package:flutter/material.dart';

class Medicine {
  final String id;
  final String name;
  final TimeOfDay time;
  final int dose;

  Medicine({
    required this.id,
    required this.name,
    required this.time,
    required this.dose,
  });
}
