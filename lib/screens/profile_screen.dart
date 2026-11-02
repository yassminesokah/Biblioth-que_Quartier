
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text('Aucun utilisateur connecté.'),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EA),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('Profil introuvable.'),
            );
          }

          final data =
              snapshot.data!.data() as Map<String, dynamic>;

          final fullName = data['fullName'] ?? 'Utilisateur';
          final email = data['email'] ?? user.email ?? '';
          final role = data['role'] ?? 'member';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xFFDCE5D5),
                  child: Icon(
                    Icons.person,
                    size: 65,
                    color: Color(0xFF526747),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF684632),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 12),

                Chip(
                  label: Text(
                    role == 'member' ? 'Membre' : role,
                  ),
                  backgroundColor: const Color(0xFFDCE5D5),
                ),

                const SizedBox(height: 30),

                ProfileOption(
                  icon: Icons.person_outline,
                  title: 'Informations personnelles',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Modification du profil bientôt disponible.',
                        ),
                      ),
                    );
                  },
                ),

                ProfileOption(
                  icon: Icons.menu_book,
                  title: 'Mes emprunts',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Consultez vos emprunts dans l’onglet dédié.',
                        ),
                      ),
                    );
                  },
                ),

                ProfileOption(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Notifications bientôt disponibles.',
                        ),
                      ),
                    );
                  },
                ),

                ProfileOption(
                  icon: Icons.help_outline,
                  title: 'Aide et assistance',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Contactez la bibliothèque depuis la messagerie.',
                        ),
                      ),
                    );
                  },
                ),

                ProfileOption(
                  icon: Icons.info_outline,
                  title: 'À propos',
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Bibliothèque de Quartier',
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                          'Application mobile de gestion de bibliothèque.',
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF526747),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
