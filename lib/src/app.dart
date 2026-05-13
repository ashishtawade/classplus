import 'package:flutter/material.dart';

import 'greetings_flow.dart';
import 'theme/app_theme.dart';

class GreetingsApp extends StatelessWidget {
  const GreetingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Greetings',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: const GreetingsFlow(),
    );
  }
}
