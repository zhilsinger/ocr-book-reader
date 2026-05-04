import 'package:flutter/material.dart';

class ChapterPasses extends StatefulWidget {
  const ChapterPasses({super.key});

  @override
  State<ChapterPasses> createState() => _ChapterPassesState();
}

class _ChapterPassesState extends State<ChapterPasses>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontSize: 12),
          tabs: const [
            Tab(text: '1st Pass\nWhat Happened'),
            Tab(text: '2nd Pass\nWhat It Means'),
            Tab(text: '3rd Pass\nModern View'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPassContent(
                'April 1976, Big Sur, California. 50 mg ketamine.\n\n'
                'Marcia Moore receives her first ketamine session from Rama '
                'at Jane\'s house. Onset within two minutes: chirping crickets '
                'sound swelling into a purring roar, visual patterns, spinning.\n\n'
                'Ego dissolution: personal identity ground away, but awareness '
                'remains. Experience lasts under one hour. Next morning: feels '
                'cleansed, reborn, world appears freshly created.',
              ),
              _buildPassContent(
                'The authors frame this as death and rebirth — not physical '
                'death, but the death of the ordinary self-structure.\n\n'
                'They interpret the experience as evidence that consciousness '
                'survives beyond the body and personality.\n\n'
                'Imagery shifts to Egyptian temples, priestesses, sarcophagi, '
                'mystery school initiation. Ketamine described as a "gift from '
                'Venus" — beautiful, elegant, not harsh like LSD.',
              ),
              _buildPassContent(
                'What holds up: Fast onset, body dissociation, ego dissolution, '
                'afterglow effects all align with modern ketamine understanding.\n\n'
                'Set and setting: Quiet room, trusted sitter, low stimulation — '
                'ahead of their time and still recommended by FDA labeling.\n\n'
                'Caution: The authors understate risks (bladder toxicity, '
                'blood pressure, addiction potential). They treat spiritual '
                'intensity as equivalent to therapeutic healing.\n\n'
                'The experience is psychologically real, but the metaphysical '
                'interpretations are meaning-making, not established fact.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPassContent(String text) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: 'serif',
              height: 1.6,
            ),
      ),
    );
  }
}
