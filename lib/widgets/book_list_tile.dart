import 'package:flutter/material.dart';

class BookListTile extends StatelessWidget {
  final Map<String, String> book;

  const BookListTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.menu_book, size: 40),
        title: Text(book['title'] ?? 'Unknown Book'),
        subtitle: Text(book['author'] ?? ''),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, '/reader'),
      ),
    );
  }
}
