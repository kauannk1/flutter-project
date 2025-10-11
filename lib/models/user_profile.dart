class UserProfile {
  final String uid;
  final String email;
  final String? nome;
  final String? ra;
  final String? fotoUrl;
  final String papel;
  final int? semestreAtual;
  final String? gradeId;
  final String? telefone;

  UserProfile({
    required this.uid,
    required this.email,
    this.nome,
    this.ra,
    this.fotoUrl,
    this.papel = 'user',
    this.semestreAtual,
    this.gradeId,
    this.telefone,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'nome': nome,
        'ra': ra,
        'fotoURL': fotoUrl,
        'papel': papel,
        'semestreAtual': semestreAtual,
        'gradeId': gradeId,
        'telefone': telefone,
      };

  factory UserProfile.fromMap(String uid, Map<String, dynamic> m) =>
      UserProfile(
        uid: uid,
        email: (m['email'] ?? '') as String,
        nome: m['nome'] as String?,
        ra: m['ra'] as String?,
        fotoUrl: (m['profileImageUrl'] ?? m['fotoURL']) as String?,
        papel: (m['papel'] ?? 'user') as String,
        semestreAtual: (m['semestreAtual'] as num?)?.toInt(),
        gradeId: m['gradeId'] as String?,
        telefone: m['telefone'] as String?,
      );

  UserProfile copyWith({String? fotoUrl}) => UserProfile(
        uid: uid,
        email: email,
        nome: nome,
        ra: ra,
        fotoUrl: fotoUrl ?? this.fotoUrl,
        papel: papel,
        semestreAtual: semestreAtual,
        gradeId: gradeId,
        telefone: telefone,
      );
}
