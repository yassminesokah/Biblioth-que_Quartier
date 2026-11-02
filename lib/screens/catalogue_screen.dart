
import 'package:flutter/material.dart';
import 'book_details_screen.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _selectedCategory = 'Tous';

  final List<Map<String, String>> books = [
    {
      'title': 'Le Petit Prince',
      'author': 'Antoine de Saint-Exupéry',
      'category': 'Roman',
      'description': 'Un voyage poétique à travers les étoiles.'
    },
    {
      'title': 'Les Misérables',
      'author': 'Victor Hugo',
      'category': 'Classique',
      'description': 'Une grande histoire de justice et de liberté.'
    },
    {
      'title': 'L’Étranger',
      'author': 'Albert Camus',
      'category': 'Roman',
      'description': 'Un roman autour de Meursault et de son histoire.'
    },
    {
      'title': 'Le Petit Nicolas',
      'author': 'René Goscinny',
      'category': 'Jeunesse',
      'description': 'Les aventures amusantes du Petit Nicolas.'
    },
  ];

  List<Map<String, String>> get filteredBooks {
    return books.where((book) {
      final matchesSearch =
          book['title']!.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) ||
          book['author']!.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              );

      final matchesCategory =
          _selectedCategory == 'Tous' ||
          book['category'] == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EA),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notre catalogue',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF684632),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Rechercher un livre ou un auteur...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Catégorie',
                border: OutlineInputBorder(),
              ),
              items: [
                'Tous',
                'Roman',
                'Classique',
                'Jeunesse',
              ].map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Text(
              '${filteredBooks.length} livre(s) trouvé(s)',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: filteredBooks.isEmpty
                  ? const Center(
                      child: Text('Aucun livre trouvé.'),
                    )
                  : ListView.builder(
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];

                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE9E1D3),
                              child: Icon(
                                Icons.menu_book,
                                color: Color(0xFF684632),
                              ),
                            ),
                            title: Text(
                              book['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${book['author']}\n${book['category']}',
                            ),
                            isThreeLine: true,
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailsScreen(book: book),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
