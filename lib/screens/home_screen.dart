import 'package:flutter/material.dart';
import '../widgets/book_list_tile.dart';
import '../widgets/processing_status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO: Connect to Rust backend for book list
  final List<Map<String, String>> _recentBooks = [];
  bool _isProcessing = false;

  Future<void> _openPdf() async {
    // TODO: Use file_picker to select PDF, then send to Rust backend
    setState(() => _isProcessing = true);
    // Simulate processing
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isProcessing = false);
      Navigator.pushNamed(context, '/reader');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR Book Reader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: _recentBooks.isEmpty
          ? _buildEmptyState()
          : _buildBookList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isProcessing ? null : _openPdf,
        icon: const Icon(Icons.add),
        label: const Text('Open PDF'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withAlpha(100),
            ),
            const SizedBox(height: 24),
            Text(
              'Open a scanned PDF to begin',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Supports scanned books, image PDFs, and two-page spreads.\n'
              'OCR runs on-device via Rust + Tesseract.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _isProcessing ? null : _openPdf,
              icon: const Icon(Icons.file_open),
              label: const Text('Open a PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _recentBooks.length,
      itemBuilder: (context, index) {
        return BookListTile(book: _recentBooks[index]);
      },
    );
  }
}
