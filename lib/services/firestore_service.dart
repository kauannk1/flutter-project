import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portal/models/class_schedule.dart';
import '../models/user_profile.dart';
import '../models/activity.dart';
import '../models/grade.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<UserProfile?> getUserProfile(String uid) async {
    final doc = await _db.collection('usuarios').doc(uid).get();
    if (!doc.exists) return null;
    return UserProfile.fromMap(uid, doc.data()!);
  }

  Future<void> saveUserProfile(UserProfile p) async {
    await _db
        .collection('usuarios')
        .doc(p.uid)
        .set(p.toMap(), SetOptions(merge: true));
  }

  Stream<List<Activity>> watchActivities() {
    return _db
        .collection('atividadesGeraisGlobais')
        .orderBy('dueDate')
        .orderBy('dueTime')
        .snapshots()
        .map((s) =>
            s.docs.map((d) => Activity.fromMap(d.id, d.data())).toList());
  }

  Stream<List<Map<String, dynamic>>> watchAvisos({int limit = 5}) {
    return _db
        .collection('avisos')
        .orderBy('dataCriacao', descending: true)
        .limit(limit)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  Stream<List<GradeItem>> watchGrades(String uid) {
    return _db
        .collection('usuarios')
        .doc(uid)
        .collection('disciplinasMatriculadas')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GradeItem.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<List<UserProfile>> getAllStudents() async {
    try {
      final snapshot = await _db
          .collection('usuarios')
          .where('papel', isEqualTo: 'aluno')
          .orderBy('nome')
          .get();
      return snapshot.docs
          .map((doc) => UserProfile.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar alunos: $e");
      return [];
    }
  }

  Future<void> saveStudentGrades(
      String studentUid, List<GradeItem> grades) async {
    final batch = _db.batch();

    for (var grade in grades) {
      final docRef = _db
          .collection('usuarios')
          .doc(studentUid)
          .collection('disciplinasMatriculadas')
          .doc(grade.disciplinaId);

      batch.set(docRef, grade.toMap(), SetOptions(merge: true));
    }

    await batch.commit();
  }

  Future<List<GradeItem>> getStudentEnrollments(String studentUid) async {
    final snapshot = await _db
        .collection('usuarios')
        .doc(studentUid)
        .collection('disciplinasMatriculadas')
        .get();

    return snapshot.docs
        .map((doc) => GradeItem.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<List<ClassScheduleItem>> getScheduleForStudent(
      UserProfile student) async {
    if (student.gradeId == null || student.semestreAtual == null) {
      return [];
    }

    try {
      final doc =
          await _db.collection('gradesCurriculares').doc(student.gradeId).get();
      if (!doc.exists) return [];

      final data = doc.data()!;
      final disciplinasMap = data['disciplinas'] as Map<String, dynamic>?;
      if (disciplinasMap == null) return [];

      final semestreKey = 'semestre${student.semestreAtual}';
      final disciplinasDoSemestre =
          disciplinasMap[semestreKey] as Map<String, dynamic>?;
      if (disciplinasDoSemestre == null) return [];

      return disciplinasDoSemestre.entries.map((entry) {
        final disciplinaId = entry.key;
        final disciplinaData = entry.value as Map<String, dynamic>;
        disciplinaData['id'] = disciplinaId;
        return ClassScheduleItem.fromMap(disciplinaData);
      }).toList();
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar horário: $e");
      return [];
    }
  }

  Future<void> uploadGradeCurricular(
      String documentId, String jsonString) async {
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    await _db.collection('gradesCurriculares').doc(documentId).set(data);
  }
}
