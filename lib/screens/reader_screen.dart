import 'package:flutter/material.dart';
import '../widgets/ocr_text_viewer.dart';
import '../widgets/chapter_passes.dart';
import '../widgets/ocr_progress_bar.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  int _currentPage = 0;
  final int _totalPages = 98;
  bool _showOcr = true;
  bool _showAnalysis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page ${_currentPage + 1} of $_totalPages'),
        actions: [
          IconButton(
            icon: Icon(_showOcr ? Icons.text_snippet : Icons.text_snippet_outlined),
            tooltip: 'OCR Text',
            onPressed: () => setState(() => _showOcr = !_showOcr),
          ),
          IconButton(
            icon: Icon(_showAnalysis ? Icons.psychology : Icons.psychology_outlined),
            tooltip: 'Deep Reading',
            onPressed: () => setState(() => _showAnalysis = !_showAnalysis),
          ),
        ],
      ),
      body: Column(
        children: [
          // PDF page view (placeholder)
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.picture_as_pdf,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Page ${_currentPage + 1}',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // OCR Progress
          const OcrProgressBar(),

          // Analysis panels
          if (_showOcr || _showAnalysis)
            Expanded(
              flex: 2,
              child: DefaultTabController(
                length: _showOcr && _showAnalysis ? 2 : 1,
                child: Column(
                  children: [
                    if (_showOcr && _showAnalysis)
                      const TabBar(
                        tabs: [
                          Tab(text: 'OCR Text'),
                          Tab(text: 'Analysis'),
                        ],
                      ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          if (_showOcr) const OcrTextViewer(),
                          if (_showAnalysis) const ChapterPasses(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      // Navigation
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _currentPage > 0
                  ? () => setState(() => _currentPage--)
                  : null,
            ),
            Text('Page ${_currentPage + 1}'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _currentPage < _totalPages - 1
                  ? () => setState(() => _currentPage++)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
