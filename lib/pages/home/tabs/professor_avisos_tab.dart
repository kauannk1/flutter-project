import 'package:flutter/material.dart';
import '../../../widgets/app_card.dart';
import '../../../services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessorAvisosTab extends StatefulWidget {
  const ProfessorAvisosTab({super.key});
  @override
  State<ProfessorAvisosTab> createState() => _ProfessorAvisosTabState();
}

class _ProfessorAvisosTabState extends State<ProfessorAvisosTab> {
  final tituloCtrl = TextEditingController();
  final conteudoCtrl = TextEditingController();
  String feedback = '';

  Future<void> _salvarAviso() async {
    final titulo = tituloCtrl.text.trim();
    final conteudo = conteudoCtrl.text.trim();
    if (titulo.isEmpty || conteudo.isEmpty) {
      setState(() => feedback = 'Preencha título e conteúdo');
      return;
    }
    final db = FirebaseFirestore.instance;
    await db.collection('avisos').add({
      'titulo': titulo,
      'conteudo': conteudo,
      'tipoAviso': 'normal',
      'autorNome': 'Professor',
      'dataCriacao': FieldValue.serverTimestamp(),
    });
    setState(() => feedback = 'Aviso salvo!');
    tituloCtrl.clear();
    conteudoCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      AppCard(
          title: 'Professor - Criar Aviso',
          icon: Icons.campaign_outlined,
          child: Column(children: [
            TextField(
                controller: tituloCtrl,
                decoration: const InputDecoration(labelText: 'Título')),
            const SizedBox(height: 8),
            TextField(
                controller: conteudoCtrl,
                decoration: const InputDecoration(labelText: 'Conteúdo')),
            const SizedBox(height: 12),
            FilledButton(
                onPressed: _salvarAviso, child: const Text('Salvar aviso')),
            if (feedback.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(feedback)),
          ])),
      const SizedBox(height: 12),
      AppCard(
          title: 'Avisos publicados',
          icon: Icons.note,
          child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: FirestoreService().watchAvisos(limit: 20),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return const SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator()));
                }
                final avisos = snap.data!;
                if (avisos.isEmpty) return const Text('Sem avisos');
                return Column(
                    children: avisos
                        .map((a) => ListTile(
                            title: Text(a['titulo'] ?? ''),
                            subtitle: Text(a['conteudo'] ?? '')))
                        .toList());
              })),
    ]);
  }
}
