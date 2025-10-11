import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // pego as cores e fontes do tema atual
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Aplicativo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Image.asset('assets/logo_fatec.png', height: 100),
          const SizedBox(height: 16),
          Text(
            'Portal do Aluno - FATEC',
            textAlign: TextAlign.center,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Text(
            'Objetivo do Projeto',
            style: textTheme.titleLarge,
          ),
          const Divider(height: 16),
          Text(
            'Desenvolver um aplicativo multiplataforma servindo como um portal para alunos e professores da FATEC, com funcionalidades como consulta de notas, horários, atividades e comunicados.',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          Text(
            'Desenvolvido por',
            style: textTheme.titleLarge,
          ),
          const Divider(height: 16),
          Text(
            'Kauan Sena',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
