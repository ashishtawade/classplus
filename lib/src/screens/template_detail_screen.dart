import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/app_user.dart';
import '../models/greeting_template.dart';
import '../utils/share_card.dart';
import '../widgets/greeting_preview_card.dart';
import '../widgets/paper_frame.dart';

class TemplateDetailScreen extends StatefulWidget {
  const TemplateDetailScreen({
    super.key,
    required this.user,
    required this.template,
  });

  final AppUser user;
  final GreetingTemplate template;

  @override
  State<TemplateDetailScreen> createState() => _TemplateDetailScreenState();
}

class _TemplateDetailScreenState extends State<TemplateDetailScreen> {
  final _boundaryKey = GlobalKey();
  bool _sharing = false;

  Future<void> _share() async {
    final boundary =
        _boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      return;
    }

    setState(() {
      _sharing = true;
    });

    try {
      await shareBoundaryImage(
        boundary,
        fileName: '${widget.template.id}.png',
        text: 'Shared from the Custom Greetings app demo.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _sharing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(widget.template.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6F1E8), Color(0xFFE9D7C3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              RepaintBoundary(
                key: _boundaryKey,
                child: GreetingPreviewCard(
                  user: widget.user,
                  template: widget.template,
                ),
              ),
              const SizedBox(height: 18),
              PaperFrame(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Why it works', style: textTheme.headlineMedium),
                    const SizedBox(height: 10),
                    Text(
                      'The exported card keeps the same layered composition shown in preview, which makes the handoff to native sharing feel direct and trustworthy.',
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Category: ${widget.template.category}',
                      style: textTheme.labelLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(widget.template.message, style: textTheme.bodyMedium),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _sharing ? null : _share,
                      icon: Icon(_sharing ? Icons.hourglass_top : Icons.share_outlined),
                      label: Text(_sharing ? 'Preparing image...' : 'Share card'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
