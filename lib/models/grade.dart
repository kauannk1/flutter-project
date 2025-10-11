import 'package:cloud_firestore/cloud_firestore.dart';

class GradeItem {
  final String disciplinaId;
  final String disciplinaNome;
  final double? p1;
  final double? p2;
  final double? trabalhos;
  final int? faltas;
  final double? media;
  final int semestre;

  GradeItem({
    required this.disciplinaId,
    required this.disciplinaNome,
    required this.semestre,
    this.p1,
    this.p2,
    this.trabalhos,
    this.faltas,
    this.media,
  });

  factory GradeItem.fromMap(String disciplinaId, Map<String, dynamic> map) {
    return GradeItem(
      disciplinaId: disciplinaId,
      disciplinaNome: map['nome'] ?? 'Disciplina Desconhecida',
      semestre: (map['semestre'] as num?)?.toInt() ?? 0,
      p1: (map['p1'] as num?)?.toDouble(),
      p2: (map['p2'] as num?)?.toDouble(),
      trabalhos: (map['trabalhos'] as num?)?.toDouble(),
      faltas: (map['faltas'] as num?)?.toInt(),
      media: (map['media'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': disciplinaNome,
      'semestre': semestre,
      'p1': p1,
      'p2': p2,
      'trabalhos': trabalhos,
      'faltas': faltas,
      'media': media,
      'atualizadoEm': FieldValue.serverTimestamp(),
    };
  }
}
