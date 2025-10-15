class ClassScheduleItem {
  final String id;
  final String nome;
  final String professor;
  final String? professorId;
  final String sala;
  final int diaSemana;
  final String horaInicio;
  final String horaFim;

  ClassScheduleItem({
    required this.id,
    required this.nome,
    required this.professor,
    required this.sala,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFim,
    this.professorId,
  });

  factory ClassScheduleItem.fromMap(Map<String, dynamic> map) {
    return ClassScheduleItem(
      id: map['id'] ?? '',
      nome: map['nome'] ?? 'Disciplina não informada',
      professor: map['professor'] ?? '',
      professorId: map['professorId'] as String?,
      sala: map['sala'] ?? '',
      diaSemana: (map['diaSemana'] as num?)?.toInt() ?? 0,
      horaInicio: map['horaInicio'] ?? '00:00',
      horaFim: map['horaFim'] ?? '00:00',
    );
  }
}
