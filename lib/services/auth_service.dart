import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient_profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream pour écouter les changements d'état de l'authentification
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Obtenir l'utilisateur actuellement connecté
  User? get currentUser => _auth.currentUser;

  // Inscription avec email et mot de passe
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
    String prenom,
    String telephone,
  ) async {
    try {
      // Créer l'utilisateur
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Créer le profil patient
        final patientProfile = PatientProfile(
          id: userCredential.user!.uid,
          prenom: prenom,
          email: email,
          telephone: telephone,
        );

        // Sauvegarder le profil dans Firestore
        await _firestore
            .collection('patients')
            .doc(userCredential.user!.uid)
            .set(patientProfile.toMap());

        // Envoyer l'email de vérification
        await userCredential.user!.sendEmailVerification();

        // Envoyer le code de vérification par SMS
        await sendSmsVerificationCode(telephone);
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // Connexion avec email et mot de passe
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Envoyer un code de vérification par SMS
  Future<void> sendSmsVerificationCode(String phoneNumber) async {
    final verificationCode = generateVerificationCode();

    // TODO: Implémenter l'envoi de SMS avec un service comme Twilio
    // Pour l'instant, on simule l'envoi
    print('Code de vérification envoyé : $verificationCode');

    // Sauvegarder le code dans Firestore pour vérification
    await _firestore.collection('verification_codes').doc(phoneNumber).set({
      'code': verificationCode,
      'createdAt': FieldValue.serverTimestamp(),
      'isUsed': false,
    });
  }

  // Vérifier le code SMS
  Future<bool> verifySmsCode(String phoneNumber, String code) async {
    final doc = await _firestore
        .collection('verification_codes')
        .doc(phoneNumber)
        .get();

    if (doc.exists && doc.data()?['code'] == code && !doc.data()?['isUsed']) {
      // Marquer le code comme utilisé
      await doc.reference.update({'isUsed': true});

      // Mettre à jour le statut de vérification du téléphone
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('patients')
            .doc(user.uid)
            .update({'isPhoneVerified': true});
      }

      return true;
    }
    return false;
  }

  // Générer un code de vérification
  String generateVerificationCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Récupérer le profil du patient
  Future<PatientProfile?> getPatientProfile(String userId) async {
    final doc = await _firestore.collection('patients').doc(userId).get();
    if (doc.exists) {
      return PatientProfile.fromMap(doc.data()!);
    }
    return null;
  }

  // Mettre à jour le profil du patient
  Future<void> updatePatientProfile(
      String userId, PatientProfile profile) async {
    await _firestore.collection('patients').doc(userId).update(profile.toMap());
  }

  // Supprimer le compte du patient
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Supprimer le profil de Firestore
      await _firestore.collection('patients').doc(user.uid).delete();
      // Supprimer le compte Firebase Auth
      await user.delete();
    }
  }
}
