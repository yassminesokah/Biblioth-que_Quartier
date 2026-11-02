
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';

import 'login_screen.dart';
import 'catalogue_screen.dart';
import 'loans_screen.dart';
import 'events_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final AuthService _authService = AuthService();

  final List<Widget> _pages = const [
    HomeContent(),
    CatalogueScreen(),
    LoansScreen(),
    EventsScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  Future<void> _logout() async {
    await _authService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.brown,
        elevation: 0,
        title: const Text(
          'Bibliothèque de Quartier',
          style: TextStyle(
            color: AppColors.brown,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(
              Icons.logout,
              color: AppColors.blue,
            ),
            tooltip: 'Déconnexion',
          ),
        ],
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        elevation: 10,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.taupe,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Catalogue',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: 'Emprunts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Événements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bonjour et bienvenue ! 👋',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.brown,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Découvrez votre espace bibliothèque.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.taupe,
            ),
          ),

          const SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'La lecture vous attend !',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explorez notre catalogue et trouvez '
                  'votre prochain livre préféré.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Nos services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.brown,
            ),
          ),

          const SizedBox(height: 15),

          const ServiceCard(
            icon: Icons.menu_book,
            title: 'Catalogue des livres',
            description: 'Découvrez les livres disponibles.',
          ),

          const ServiceCard(
            icon: Icons.bookmark,
            title: 'Mes emprunts',
            description: 'Suivez vos emprunts et réservations.',
          ),

          const ServiceCard(
            icon: Icons.event,
            title: 'Événements',
            description: 'Participez aux activités de la bibliothèque.',
          ),

          const ServiceCard(
            icon: Icons.message,
            title: 'Messagerie',
            description: 'Communiquez avec la bibliothèque.',
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.sageGreen,
          child: Icon(
            icon,
            color: AppColors.darkGreen,
            size: 25,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.brown,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            color: AppColors.taupe,
          ),
        ),
      ),
    );
  }
}
