import 'dart:ui';
import 'package:flutter/material.dart';

class Meeting {
  final DateTime from;
  final DateTime to;
  final String eventName;
  final Color background;
  final String description;

  Meeting({
   this.eventName = "", required this.from, required this.to, this.background = Colors.green, this.description = ""
  });
}