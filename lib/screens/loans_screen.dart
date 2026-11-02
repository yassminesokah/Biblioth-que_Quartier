
import 'package:flutter/material.dart';

class LoansScreen extends StatelessWidget {
  const LoansScreen({super.key});

  final List<Map<String, String>> loans = const [
    {
      'title': 'Le Petit Prince',
      'author': 'Antoine de Saint-Exupéry',
      'date': '05/11/2026',
      'status': 'En cours',
    },
    {
      'title': 'Les Misérables',
      'author': 'Victor Hugo',
      'date': '10/11/2026',
      'status': 'À retourner',
    },
  ];

  final List<Map<String, String>> reservations = const [
    {
      'title': 'L’Étranger',
      'author': 'Albert Camus',
      'status': 'En attente',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mes emprunts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF684632),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Livres empruntés',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...loans.map((loan) {
              return LoanCard(loan: loan);
            }),

            const SizedBox(height: 25),

            const Text(
              'Mes réservations',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...reservations.map((reservation) {
              return ReservationCard(reservation: reservation);
            }),
          ],
        ),
      ),
    );
  }
}

class LoanCard extends StatelessWidget {
  final Map<String, String> loan;

  const LoanCard({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
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
          loan['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Auteur : ${loan['author']}\nRetour prévu : ${loan['date']}',
        ),
        isThreeLine: true,
        trailing: const Icon(
          Icons.check_circle,
          color: Color(0xFF526747),
        ),
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final Map<String, String> reservation;

  const ReservationCard({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(
          Icons.bookmark,
          color: Color(0xFFC76D4A),
        ),
        title: Text(
          reservation['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Auteur : ${reservation['author']}',
        ),
        trailing: Chip(
          label: Text(reservation['status']!),
          backgroundColor: const Color(0xFFFFE5D9),
        ),
      ),
    );
  }
}
