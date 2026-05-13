import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/greeting_template.dart';
import 'avatar_stamp.dart';

class GreetingPreviewCard extends StatelessWidget {
  const GreetingPreviewCard({
    super.key,
    required this.user,
    required this.template,
    this.compact = false,
  });

  final AppUser user;
  final GreetingTemplate template;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final radius = compact ? 20.0 : 30.0;

    return AspectRatio(
      aspectRatio: 0.82,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(compact ? 24 : 30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: template.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Align(
              alignment: template.patternAlignment,
              child: FractionallySizedBox(
                widthFactor: compact ? 0.5 : 0.54,
                heightFactor: compact ? 0.38 : 0.42,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(160),
                  ),
                ),
              ),
            ),
            Positioned(
              top: compact ? 16 : 22,
              left: compact ? 16 : 22,
              child: _StatusBadge(
                label: template.badgeText,
                isPremium: template.isPremium,
              ),
            ),
            Positioned(
              top: compact ? 16 : 22,
              right: compact ? 16 : 22,
              child: AvatarStamp(
                name: user.displayName,
                seed: user.avatarSeed,
                accentColor: user.accentColor,
                radius: radius,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(compact ? 18 : 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    template.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: compact ? 22 : 28,
                      fontWeight: FontWeight.w700,
                      height: 0.95,
                      letterSpacing: -0.6,
                    ),
                  ),
                  SizedBox(height: compact ? 10 : 14),
                  Text(
                    template.message,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: compact ? 12.5 : 14.5,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: compact ? 14 : 18),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFDE68A),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Made for ${user.displayName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: compact ? 12.5 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.isPremium,
  });

  final String label;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isPremium ? const Color(0xFF171717) : Colors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPremium ? Colors.white : const Color(0xFF171717),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
