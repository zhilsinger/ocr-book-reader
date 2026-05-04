import 'package:flutter/material.dart';

class OcrTextViewer extends StatelessWidget {
  const OcrTextViewer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Connect to Rust backend OCR results via rinf streams
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('OCR Text', style: Theme.of(context).textTheme.titleSmall),
              TextButton(
                onPressed: () {},
                child: const Text('Show Raw'),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                'Anesthetic drugs with actions at specific sites in the central '
                'nervous system have been sought for a long time as alternatives '
                'to general anesthetics which have far-reaching effects on the '
                'brain. The most successful of these to date has been ketamine.\n\n'
                '— Introduction to Anesthesia, Dripps & Eckenhoff',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'serif',
                      height: 1.6,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
