import 'package:flutter/material.dart';
import '../../../widgets/app_card.dart';

class CursoTab extends StatelessWidget {
  const CursoTab({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: const [
      AppCard(
          title: 'Meu curso (ADS)',
          icon: Icons.menu_book_outlined,
          child: Text(
              'Ementas, carga horária e trilha do semestre. (Conteúdo estático por enquanto)')),
    ]);
  }
}
