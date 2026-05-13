import 'package:flutter/material.dart';

import '../widgets/editorial_shell.dart';
import '../widgets/paper_frame.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return EditorialShell(
      topLabel: 'Custom Greetings',
      title: 'Cards that feel personal before you even hit share.',
      subtitle:
          'Choose a sign-in path to start building greeting cards with your own name and avatar already woven into each design.',
      child: PaperFrame(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign in', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'This demo keeps auth lightweight while preserving the full flow from the PRD.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 22),
            _LoginChoice(
              label: 'Continue with Google',
              caption: 'Fastest path for a familiar mobile sign-in.',
              onTap: () => onSelected('Google'),
            ),
            const SizedBox(height: 14),
            _LoginChoice(
              label: 'Use Email',
              caption: 'A simple credential-style entry point for expansion later.',
              onTap: () => onSelected('Email'),
            ),
            const SizedBox(height: 14),
            _LoginChoice(
              label: 'Enter as Guest',
              caption: 'Jump into the card experience without account friction.',
              onTap: () => onSelected('Guest'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginChoice extends StatelessWidget {
  const _LoginChoice({
    required this.label,
    required this.caption,
    required this.onTap,
  });

  final String label;
  final String caption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFD9CFC3)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF3ECE1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.arrow_outward_rounded, color: Color(0xFF171717)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(caption, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
