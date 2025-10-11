import 'package:flutter/material.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/empty_state.dart';
import '../../../services/firestore_service.dart';
import '../../../models/activity.dart';

class AtividadesTab extends StatelessWidget {
  const AtividadesTab({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      AppCard(
          title: 'Minhas atividades',
          icon: Icons.checklist_outlined,
          child: StreamBuilder<List<Activity>>(
            stream: FirestoreService().watchActivities(),
            builder: (context, snap) {
              if (!snap.hasData)
                return const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator()));
              final items = snap.data!;
              if (items.isEmpty) return const EmptyState('Sem atividades.');
              return Column(
                  children: items
                      .map((a) => ListTile(
                          leading: const Icon(Icons.task_alt_outlined),
                          title: Text(a.title),
                          subtitle: Text(a.description),
                          trailing: Text('${a.due.day}/${a.due.month}')))
                      .toList());
            },
          ))
    ]);
  }
}
