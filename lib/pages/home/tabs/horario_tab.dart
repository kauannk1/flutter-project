import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Usado para formatar o dia da semana
import 'package:portal/models/class_schedule.dart';
import 'package:portal/models/user_profile.dart';
import 'package:portal/services/firestore_service.dart';
import 'package:portal/widgets/app_card.dart';
import 'package:portal/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class HorarioTab extends StatefulWidget {
  const HorarioTab({super.key});

  @override
  State<HorarioTab> createState() => _HorarioTabState();
}

class _HorarioTabState extends State<HorarioTab> {
  late Future<List<ClassScheduleItem>> _scheduleFuture;

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  void _loadSchedule() {
    final userProfile = Provider.of<UserProfile>(context, listen: false);
    _scheduleFuture = FirestoreService().getScheduleForStudent(userProfile);
  }

  // Encontra a próxima aula
  ClassScheduleItem? _findNextClass(List<ClassScheduleItem> schedule) {
    if (schedule.isEmpty) return null;

    final now = DateTime.now();
    // No Dart, Segunda = 1, Domingo = 7. No BD, Segunda = 2.
    // foi ajustado
    final currentDay = now.weekday + 1;
    final currentTimeInMinutes = now.hour * 60 + now.minute;

    // Ordena todo o horário por dia e depois por hora
    schedule.sort((a, b) {
      if (a.diaSemana != b.diaSemana) {
        return a.diaSemana.compareTo(b.diaSemana);
      }
      return a.horaInicio.compareTo(b.horaInicio);
    });

    // Procura por uma aula futura no dia de hoje
    var nextClass = schedule.firstWhere(
      (aula) =>
          aula.diaSemana == currentDay &&
          _timeToMinutes(aula.horaInicio) > currentTimeInMinutes,
      orElse: () => schedule.first, // Valor padrão temporário
    );
    // Se o valor padrão foi usado, a busca falhou.
    if (nextClass.diaSemana != currentDay ||
        _timeToMinutes(nextClass.horaInicio) <= currentTimeInMinutes) {
      //  Se não encontrou, procura por uma aula em um dia futuro nesta semana
      nextClass = schedule.firstWhere(
        (aula) => aula.diaSemana > currentDay,
        orElse: () => schedule.first, // Valor padrão temporário
      );
      // Se o valor padrão foi usado, a busca falhou.
      if (nextClass.diaSemana <= currentDay) {
        // Se não encontrou, pega a primeira aula da próxima semana (que é a primeira da lista ordenada)
        return schedule.first;
      }
    }

    return nextClass;
  }

  int _timeToMinutes(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  String _dayOfWeekToString(int day) {
    const days = {
      2: 'Segunda-Feira',
      3: 'Terça-Feira',
      4: 'Quarta-Feira',
      5: 'Quinta-Feira',
      6: 'Sexta-Feira'
    };
    return days[day] ?? 'Dia Inválido';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ClassScheduleItem>>(
      future: _scheduleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: EmptyState('Nenhum horário encontrado.'));
        }

        final fullSchedule = snapshot.data!;
        final nextClass = _findNextClass(fullSchedule);

        // Agrupa as aulas por dia da semana
        final Map<int, List<ClassScheduleItem>> scheduleByDay = {};
        for (var aula in fullSchedule) {
          if (!scheduleByDay.containsKey(aula.diaSemana)) {
            scheduleByDay[aula.diaSemana] = [];
          }
          scheduleByDay[aula.diaSemana]!.add(aula);
        }
        // Ordena os dias da semana
        final sortedDays = scheduleByDay.keys.toList()..sort();

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Card de Próxima Aula
            _NextClassCard(nextClass: nextClass),

            const SizedBox(height: 24),

            // Título para a seção de horário completo
            Text(
              'Horário da Semana',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),

            // Lista de aulas da semana inteira
            ...sortedDays.map((day) {
              final dailySchedule = scheduleByDay[day]!;
              dailySchedule
                  .sort((a, b) => a.horaInicio.compareTo(b.horaInicio));
              return _DayScheduleSection(
                dayTitle: _dayOfWeekToString(day),
                schedule: dailySchedule,
              );
            }),
          ],
        );
      },
    );
  }
}

// Widget para o Card de "Próxima Aula"
class _NextClassCard extends StatelessWidget {
  final ClassScheduleItem? nextClass;
  const _NextClassCard({this.nextClass});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (nextClass == null) {
      return const AppCard(
          title: 'Próxima Aula',
          icon: Icons.watch_later_outlined,
          child: Text('Nenhuma aula programada.'));
    }

    // Formata o dia da semana para exibição
    final today = DateTime.now().weekday + 1;
    final dayDescription = nextClass!.diaSemana == today
        ? 'Hoje'
        : DateFormat('EEEE', 'pt_BR').format(
            DateTime.now().add(Duration(days: nextClass!.diaSemana - today)));

    return AppCard(
      title: 'Próxima Aula',
      icon: Icons.watch_later_outlined,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(nextClass!.nome,
            style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${nextClass!.professor} • Sala: ${nextClass!.sala}'),
            const SizedBox(height: 8),
            Text(
              '$dayDescription, ${nextClass!.horaInicio} - ${nextClass!.horaFim}',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para exibir a seção de um dia da semana
class _DayScheduleSection extends StatelessWidget {
  final String dayTitle;
  final List<ClassScheduleItem> schedule;
  const _DayScheduleSection({required this.dayTitle, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dayTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: schedule.map((aula) {
                return _ClassInfoTile(aula: aula);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para exibir cada aula
class _ClassInfoTile extends StatelessWidget {
  final ClassScheduleItem aula;
  const _ClassInfoTile({required this.aula});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      tileColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(aula.horaInicio,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary)),
          const Text('às'),
          Text(aula.horaFim,
              style: TextStyle(color: theme.textTheme.bodySmall?.color)),
        ],
      ),
      title:
          Text(aula.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(aula.professor),
      trailing: Chip(
        label: Text('Sala: ${aula.sala}'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
    );
  }
}
