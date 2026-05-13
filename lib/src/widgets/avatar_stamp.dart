import 'package:flutter/material.dart';

class AvatarStamp extends StatelessWidget {
  const AvatarStamp({
    super.key,
    required this.name,
    required this.seed,
    required this.accentColor,
    this.radius = 28,
  });

  final String name;
  final String seed;
  final int accentColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    final color = Color(accentColor);

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color, Color.lerp(color, Colors.white, 0.42)!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.84), width: 3),
      ),
      child: Center(
        child: Text(
          initials.isEmpty ? seed.substring(0, 1).toUpperCase() : initials,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: radius * 0.58,
          ),
        ),
      ),
    );
  }
}
