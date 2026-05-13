import 'package:flutter/material.dart';

import '../data/template_catalog.dart';
import '../models/app_user.dart';
import '../models/greeting_template.dart';
import '../widgets/editorial_shell.dart';
import '../widgets/greeting_preview_card.dart';
import '../widgets/paper_frame.dart';
import 'template_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.onEditProfile,
  });

  final AppUser user;
  final VoidCallback onEditProfile;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = categories.first;

  List<GreetingTemplate> get _templates => templateCatalog
      .where((template) => template.category == _selectedCategory)
      .toList(growable: false);

  Future<void> _openTemplate(GreetingTemplate template) async {
    if (template.isPremium) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFFFFFBF5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          title: const Text('Premium template'),
          content: const Text(
            'Unlock premium designs, exports without limits, and richer seasonal collections.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Maybe later'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('View plans'),
            ),
          ],
        ),
      );
      return;
    }

    if (!mounted) {
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TemplateDetailScreen(
          user: widget.user,
          template: template,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EditorialShell(
      topLabel: 'Gallery',
      title: 'Browse fast, personalize instantly.',
      subtitle:
          'Every template already carries your identity, so the home feed doubles as a live preview surface.',
      trailing: IconButton.outlined(
        onPressed: widget.onEditProfile,
        icon: const Icon(Icons.edit_outlined),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaperFrame(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Hello, ${widget.user.displayName}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3ECE1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '8 curated templates',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  selectedColor: const Color(0xFF171717),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF171717),
                    fontWeight: FontWeight.w700,
                  ),
                  backgroundColor: Colors.white,
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _templates.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.67,
            ),
            itemBuilder: (context, index) {
              final template = _templates[index];
              return InkWell(
                onTap: () => _openTemplate(template),
                borderRadius: BorderRadius.circular(26),
                child: GreetingPreviewCard(
                  user: widget.user,
                  template: template,
                  compact: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
