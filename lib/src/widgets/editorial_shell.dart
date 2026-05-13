import 'package:flutter/material.dart';

class EditorialShell extends StatelessWidget {
  const EditorialShell({
    super.key,
    required this.child,
    required this.topLabel,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final Widget child;
  final String topLabel;
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6F1E8), Color(0xFFEBDCCB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - 46),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (trailing != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: trailing,
                        ),
                      Text(
                        topLabel.toUpperCase(),
                        style: textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF8B6F47),
                          letterSpacing: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(title, style: textTheme.displaySmall),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Text(subtitle, style: textTheme.bodyLarge),
                      ),
                      const SizedBox(height: 28),
                      child,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
