import 'package:flutter/material.dart';
import 'package:portal/data/grade_curricular_data.dart';
import 'package:portal/services/firestore_service.dart';
import 'package:portal/widgets/app_card.dart';

class AdminToolsPage extends StatelessWidget {
  const AdminToolsPage({super.key});

  Future<void> _uploadGrade(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
            content: Text('Enviando grade curricular para o Firestore...')),
      );

      await FirestoreService().uploadGradeCurricular(
        'ads_2025_diurno',
        gradeCurricularCompletaJson,
      );

      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('SUCESSO! Grade curricular completa foi salva.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('ERRO: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferramentas do Professor'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            title: 'Popular Banco de Dados',
            icon: Icons.upload_file,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Esta ação irá criar/sobrescrever o documento da grade curricular "ads_2025_diurno" com os dados de TODOS os semestres.',
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _uploadGrade(context),
                  icon: const Icon(Icons.cloud_upload_outlined),
                  label: const Text('Carregar Grade Curricular Completa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
