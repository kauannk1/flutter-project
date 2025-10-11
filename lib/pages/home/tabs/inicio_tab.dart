import 'package:flutter/material.dart';
import '../../../widgets/app_card.dart';
import '../../../services/firestore_service.dart';

class InicioTab extends StatelessWidget {
  const InicioTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      AppCard(
          title: 'Bem-vindo!',
          icon: Icons.waving_hand_outlined,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Portal do Aluno - FATEC RP'),
                SizedBox(height: 8),
                Text('Confira seus avisos e próximas aulas.'),
              ])),
      const SizedBox(height: 12),
      AppCard(
          title: 'Avisos recentes',
          icon: Icons.campaign_outlined,
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: FirestoreService().watchAvisos(),
            builder: (context, snap) {
              if (!snap.hasData)
                return const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator()));
              final avisos = snap.data!;
              if (avisos.isEmpty) return const Text('Nenhum aviso recente.');
              return Column(
                  children: avisos
                      .map((a) => ListTile(
                          leading: const Icon(Icons.campaign_outlined),
                          title: Text(a['titulo'] ?? 'Aviso'),
                          subtitle: Text(a['conteudo'] ?? '')))
                      .toList());
            },
          )),
    ]);
  }
}
