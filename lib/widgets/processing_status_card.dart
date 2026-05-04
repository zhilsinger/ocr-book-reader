import 'package:flutter/material.dart';

class ProcessingStatusCard extends StatelessWidget {
  final String title;
  final String status;
  final double progress;
  final int current;
  final int total;

  const ProcessingStatusCard({
    super.key,
    required this.title,
    required this.status,
    this.progress = 0,
    this.current = 0,
    this.total = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                Chip(
                  label: Text(status, style: const TextStyle(fontSize: 11)),
                  backgroundColor: _statusColor(status),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: progress),
            if (total > 0)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '$current / $total pages',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'ready':
        return Colors.green.shade100;
      case 'processing':
        return Colors.blue.shade100;
      case 'error':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}
