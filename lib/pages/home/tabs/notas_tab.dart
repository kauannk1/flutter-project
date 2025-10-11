import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portal/models/grade.dart';
import 'package:portal/services/firestore_service.dart';
import 'package:portal/widgets/empty_state.dart';

class NotasTab extends StatefulWidget {
  const NotasTab({super.key});

  @override
  State<NotasTab> createState() => _NotasTabState();
}

class _NotasTabState extends State<NotasTab> {
  late final Stream<List<GradeItem>> _gradesStream;

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    _gradesStream = FirestoreService().watchGrades(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<GradeItem>>(
        stream: _gradesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
                child: EmptyState('Não foi possível carregar as notas.'));
          }
          final grades = snapshot.data;
          if (grades == null || grades.isEmpty) {
            return const Center(
                child: EmptyState('Nenhuma nota lançada até o momento.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 720;
              final cardWidth = isWideScreen
                  ? (constraints.maxWidth / 2) - 24
                  : constraints.maxWidth;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: grades.map((grade) {
                    return SizedBox(
                      width: cardWidth,
                      child: SubjectGradeCard(grade: grade),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SubjectGradeCard extends StatelessWidget {
  final GradeItem grade;
  const SubjectGradeCard({super.key, required this.grade});

  Color _getGradeColor(double? media) {
    if (media == null) return Colors.grey;
    if (media >= 7.0) return Colors.green.shade600;
    if (media >= 5.0) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  String _getStatus(double? media) {
    if (media == null) return "Cursando";
    if (media >= 6.0) return "Aprovado";
    if (media >= 4.0) return "Recuperação";
    return "Reprovado";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = grade.media;
    final mediaColor = _getGradeColor(media);
    final statusText = _getStatus(media);
    final progressWidth = (media != null && media >= 0) ? (media / 10.0) : 0.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: theme.colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              grade.disciplinaNome,
              style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.surfaceVariant.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: constraints.maxWidth * progressWidth,
                          height: 80,
                          decoration: BoxDecoration(
                            color: mediaColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Média', style: theme.textTheme.bodySmall),
                          Text(
                            media?.toStringAsFixed(1) ?? '-',
                            style: theme.textTheme.displaySmall?.copyWith(
                                color: mediaColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _GradeDetailItem(
                        label: 'P1',
                        value: grade.p1?.toStringAsFixed(1) ?? '-'),
                    _GradeDetailItem(
                        label: 'P2',
                        value: grade.p2?.toStringAsFixed(1) ?? '-'),
                    _GradeDetailItem(
                        label: 'Trabalhos',
                        value: grade.trabalhos?.toStringAsFixed(1) ?? '-'),
                    _GradeDetailItem(
                        label: 'Faltas',
                        value: grade.faltas?.toString() ?? '0'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Situação: $statusText',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.right),
          )
        ],
      ),
    );
  }
}

class _GradeDetailItem extends StatelessWidget {
  final String label;
  final String value;
  const _GradeDetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 2),
          Text(value,
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
