import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _psm = 6;
  double _contrast = 1.4;
  String _language = 'eng';
  bool _autoSplitSpreads = true;
  bool _stripHeaders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // OCR Engine
          Text('OCR Engine', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              children: [
                DropdownButtonFormField<String>(
                  value: _language,
                  decoration: const InputDecoration(
                    labelText: 'Language',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'eng', child: Text('English')),
                    DropdownMenuItem(value: 'fra', child: Text('French')),
                    DropdownMenuItem(value: 'deu', child: Text('German')),
                    DropdownMenuItem(value: 'spa', child: Text('Spanish')),
                  ],
                  onChanged: (v) => setState(() => _language = v!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: _psm,
                  decoration: const InputDecoration(
                    labelText: 'Page Segmentation Mode (PSM)',
                    helperText: 'PSM 6 = single block (best for books)',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 3, child: Text('3 — Auto (full page)')),
                    DropdownMenuItem(value: 4, child: Text('4 — Sparse text')),
                    DropdownMenuItem(value: 6, child: Text('6 — Single block (recommended)')),
                    DropdownMenuItem(value: 7, child: Text('7 — Single line')),
                  ],
                  onChanged: (v) => setState(() => _psm = v!),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Text('Image Processing', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Contrast: ${_contrast.toStringAsFixed(1)}x'),
                Slider(
                  value: _contrast,
                  min: 1.0,
                  max: 2.5,
                  divisions: 15,
                  label: '${_contrast.toStringAsFixed(1)}x',
                  onChanged: (v) => setState(() => _contrast = v),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Auto-split two-page spreads'),
                  subtitle: const Text('Detect and split wide pages automatically'),
                  value: _autoSplitSpreads,
                  onChanged: (v) => setState(() => _autoSplitSpreads = v),
                ),
                SwitchListTile(
                  title: const Text('Strip running headers'),
                  subtitle: const Text('Remove repeated headers and page numbers'),
                  value: _stripHeaders,
                  onChanged: (v) => setState(() => _stripHeaders = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
