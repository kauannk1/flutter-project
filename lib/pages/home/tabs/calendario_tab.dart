import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../widgets/app_card.dart';

class CalendarioTab extends StatefulWidget {
  const CalendarioTab({super.key});
  @override
  State<CalendarioTab> createState() => _CalendarioTabState();
}

class _CalendarioTabState extends State<CalendarioTab> {
  DateTime focused = DateTime.now();
  DateTime? selected;
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      AppCard(
          title: 'Calendário',
          icon: Icons.calendar_month_outlined,
          child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focused,
              selectedDayPredicate: (d) => isSameDay(d, selected),
              onDaySelected: (s, f) => setState(() {
                    selected = s;
                    focused = f;
                  }),
              locale: 'pt_BR')),
    ]);
  }
}
