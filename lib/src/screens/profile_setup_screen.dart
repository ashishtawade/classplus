import 'dart:math';

import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../widgets/avatar_stamp.dart';
import '../widgets/editorial_shell.dart';
import '../widgets/paper_frame.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({
    super.key,
    required this.loginLabel,
    required this.onSaved,
  });

  final String loginLabel;
  final ValueChanged<AppUser> onSaved;

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _controller = TextEditingController(text: 'Aarav Mehta');
  final _formKey = GlobalKey<FormState>();
  final _palette = const [
    Color(0xFFB0413E),
    Color(0xFF16697A),
    Color(0xFF6A4C93),
    Color(0xFF3D5A40),
    Color(0xFF7C5C3B),
  ];
  int _selectedIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final seed = '${widget.loginLabel}-${Random().nextInt(9999)}';
    widget.onSaved(
      AppUser(
        displayName: _controller.text.trim(),
        accentColor: _palette[_selectedIndex].toARGB32(),
        avatarSeed: seed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EditorialShell(
      topLabel: widget.loginLabel,
      title: 'Give the cards a face and a name.',
      subtitle:
          'The live previews use your profile details immediately, so even the browsing experience feels customized.',
      child: PaperFrame(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AvatarStamp(
                    name: _controller.text,
                    seed: widget.loginLabel,
                    accentColor: _palette[_selectedIndex].toARGB32(),
                    radius: 34,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Your avatar is generated locally from your name and selected accent tone for this demo.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Display name',
                  hintText: 'Enter the name shown on each card',
                ),
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().length < 2) {
                    return 'Please enter at least 2 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text('Choose an accent', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_palette.length, (index) {
                  final color = _palette[index];
                  final selected = index == _selectedIndex;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                        border: Border.all(
                          color: selected ? const Color(0xFF171717) : Colors.white,
                          width: selected ? 3 : 2,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Open the card gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
