
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  final List<Map<String, String>> events = const [
    {
      'title': 'Club de lecture',
      'date': '05 Novembre 2026',
      'time': '14:00',
      'location': 'Salle principale',
      'description': 'Un moment de partage autour de nos livres préférés.',
    },
    {
      'title': 'Atelier pour enfants',
      'date': '10 Novembre 2026',
      'time': '10:00',
      'location': 'Espace jeunesse',
      'description': 'Une activité créative pour découvrir le plaisir de lire.',
    },
    {
      'title': 'Rencontre littéraire',
      'date': '15 Novembre 2026',
      'time': '16:00',
      'location': 'Salle de conférence',
      'description': 'Échange et discussion autour de la littérature.',
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
              'Événements',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF684632),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Découvrez les activités de votre bibliothèque.',
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 25),

            ...events.map((event) {
              return EventCard(event: event);
            }),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, String> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.event,
              size: 35,
              color: Color(0xFFC76D4A),
            ),

            const SizedBox(height: 12),

            Text(
              event['title']!,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF684632),
              ),
            ),

            const SizedBox(height: 10),

            Text('📅 ${event['date']}'),
            Text('🕒 ${event['time']}'),
            Text('📍 ${event['location']}'),

            const SizedBox(height: 12),

            Text(
              event['description']!,
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Inscription à "${event['title']}" bientôt disponible.',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF526747),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Participer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
