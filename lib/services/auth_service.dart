
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Inscription d'un nouvel utilisateur
  Future<UserModel?> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      User? user = result.user;

      if (user == null) return null;

      UserModel newUser = UserModel(
        uid: user.uid,
        fullName: fullName.trim(),
        email: email.trim(),
        role: 'member',
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(newUser.toMap());

      return newUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Erreur lors de l’inscription');
    }
  }

  // Connexion d'un utilisateur
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Erreur lors de la connexion');
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Récupérer l'utilisateur connecté
  User? get currentUser => _auth.currentUser;
}
