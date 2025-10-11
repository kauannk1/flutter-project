import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile.dart';
import 'firestore_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _fs = FirestoreService();

  Future<UserCredential> signIn(String email, String senha) {
    return _auth.signInWithEmailAndPassword(email: email, password: senha);
  }

  Future<UserCredential> register({
    required String email,
    required String password,
    required String nome,
    required String ra,
    required String curso,
    required String turno,
    required int semestre,
    required String? telefone,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final String papel =
        email.toLowerCase().endsWith('-prof@fatec.com') ? 'professor' : 'aluno';

    final anoIngresso = DateTime.now().year.toString();
    final String? gradeId = papel == 'aluno'
        ? '${curso}_${anoIngresso}_$turno' // ex: 'ads_2025_diurno'
        : null;

    final profile = UserProfile(
      uid: cred.user!.uid,
      email: email,
      nome: nome,
      ra: ra,
      papel: papel,
      semestreAtual: semestre,
      gradeId: gradeId,
      telefone: telefone,
    );

    await _fs.saveUserProfile(profile);
    return cred;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('erro ao enviar e-mail de recuperação: $e');
    }
  }

  Future<void> signOut() => _auth.signOut();
}
