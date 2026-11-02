
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  final Map<String, String> book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EA),

      appBar: AppBar(
        title: const Text('Détails du livre'),
        backgroundColor: const Color(0xFFF7F3EA),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFE9E1D3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.menu_book,
                size: 100,
                color: Color(0xFF684632),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              book['title'] ?? '',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF684632),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Auteur : ${book['author'] ?? 'Non renseigné'}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFDCE5D5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                book['category'] ?? 'Non classé',
                style: const TextStyle(
                  color: Color(0xFF526747),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF684632),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              book['description'] ?? 'Aucune description disponible.',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'La réservation sera disponible prochainement.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.bookmark_add),
              label: const Text('Réserver ce livre'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF526747),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
