import 'package:flutter/material.dart';

class GreetingTemplate {
  const GreetingTemplate({
    required this.id,
    required this.title,
    required this.category,
    required this.message,
    required this.isPremium,
    required this.colors,
    required this.badgeText,
    required this.patternAlignment,
  });

  final String id;
  final String title;
  final String category;
  final String message;
  final bool isPremium;
  final List<Color> colors;
  final String badgeText;
  final Alignment patternAlignment;
}
