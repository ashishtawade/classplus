import 'package:flutter/material.dart';

import 'models/app_user.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_setup_screen.dart';

class GreetingsFlow extends StatefulWidget {
  const GreetingsFlow({super.key});

  @override
  State<GreetingsFlow> createState() => _GreetingsFlowState();
}

class _GreetingsFlowState extends State<GreetingsFlow> {
  String? _selectedLoginLabel;
  AppUser? _user;

  void _handleLoginChoice(String label) {
    setState(() {
      _selectedLoginLabel = label;
    });
  }

  void _handleProfileSaved(AppUser user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedLoginLabel == null) {
      return LoginScreen(onSelected: _handleLoginChoice);
    }

    if (_user == null) {
      return ProfileSetupScreen(
        loginLabel: _selectedLoginLabel!,
        onSaved: _handleProfileSaved,
      );
    }

    return HomeScreen(
      user: _user!,
      onEditProfile: () {
        setState(() {
          _user = null;
        });
      },
    );
  }
}
