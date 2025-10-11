import 'package:flutter/material.dart';
import 'package:portal/models/class_schedule.dart';
import 'package:portal/models/grade.dart';
import 'package:portal/models/user_profile.dart';
import 'package:portal/services/firestore_service.dart';
import 'package:portal/widgets/app_card.dart';
import 'package:portal/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class ProfessorNotasTab extends StatefulWidget {
  const ProfessorNotasTab({super.key});

  @override
  State<ProfessorNotasTab> createState() => _ProfessorNotasTabState();
}

class _ProfessorNotasTabState extends State<ProfessorNotasTab> {
  final _firestoreService = FirestoreService();

  List<UserProfile> _students = [];
  UserProfile? _selectedStudent;
  bool _isLoadingStudents = true;
  bool _isLoadingGrades = false;

  List<GradeItem> _professorSubjectsForStudent = [];

  Map<String, Map<String, TextEditingController>> _controllers = {};

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  @override
  void dispose() {
    _controllers.forEach(
        (_, map) => map.forEach((_, controller) => controller.dispose()));
    super.dispose();
  }

  Future<void> _fetchStudents() async {
    setState(() => _isLoadingStudents = true);
    _students = await _firestoreService.getAllStudents();
    if (mounted) {
      setState(() => _isLoadingStudents = false);
    }
  }

  Future<void> _onStudentSelected(UserProfile? student) async {
    setState(() {
      _selectedStudent = student;
      _isLoadingGrades = student != null;
      _controllers
          .forEach((_, map) => map.forEach((_, ctrl) => ctrl.dispose()));
      _controllers = {};
      _professorSubjectsForStudent = [];
    });

    if (student == null) return;

    final professorId = Provider.of<UserProfile>(context, listen: false).uid;
    final allEnrollments =
        await _firestoreService.getStudentEnrollments(student.uid);
    final officialSchedule =
        await _firestoreService.getScheduleForStudent(student);

    final filteredEnrollments = allEnrollments.where((enrollment) {
      final matchingSubject = officialSchedule.any((subject) {
        return subject.id == enrollment.disciplinaId &&
            subject.professorId == professorId;
      });
      return matchingSubject;
    }).toList();

    for (var enrollment in filteredEnrollments) {
      final disciplineId = enrollment.disciplinaId;
      _controllers[disciplineId] = {
        'p1': TextEditingController(text: enrollment.p1?.toString() ?? ''),
        'p2': TextEditingController(text: enrollment.p2?.toString() ?? ''),
        'trabalhos':
            TextEditingController(text: enrollment.trabalhos?.toString() ?? ''),
        'faltas':
            TextEditingController(text: enrollment.faltas?.toString() ?? ''),
      };
    }

    if (mounted) {
      setState(() {
        _professorSubjectsForStudent = filteredEnrollments;
        _isLoadingGrades = false;
      });
    }
  }

  Future<void> _saveGrades() async {
    if (_selectedStudent == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Salvando notas...')),
    );

    final List<GradeItem> gradesToSave = [];

    for (var enrollment in _professorSubjectsForStudent) {
      final discId = enrollment.disciplinaId;
      final p1 = double.tryParse(_controllers[discId]!['p1']!.text);
      final p2 = double.tryParse(_controllers[discId]!['p2']!.text);
      final trabalhos =
          double.tryParse(_controllers[discId]!['trabalhos']!.text);
      final faltas = int.tryParse(_controllers[discId]!['faltas']!.text);

      final validGrades = [p1, p2, trabalhos].whereType<double>().toList();
      final media = validGrades.isNotEmpty
          ? validGrades.reduce((a, b) => a + b) / validGrades.length
          : null;

      gradesToSave.add(GradeItem(
        disciplinaId: discId,
        disciplinaNome: enrollment.disciplinaNome,
        semestre: enrollment.semestre,
        p1: p1,
        p2: p2,
        trabalhos: trabalhos,
        faltas: faltas,
        media: media,
      ));
    }

    try {
      await _firestoreService.saveStudentGrades(
          _selectedStudent!.uid, gradesToSave);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Notas salvas com sucesso!'),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro ao salvar: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppCard(
          title: 'Selecionar Aluno',
          icon: Icons.person_search,
          child: _isLoadingStudents
              ? const Center(child: CircularProgressIndicator())
              : DropdownButtonFormField<UserProfile>(
                  value: _selectedStudent,
                  isExpanded: true,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  hint: const Text('Selecione um aluno'),
                  items: _students.map((student) {
                    return DropdownMenuItem(
                      value: student,
                      child: Text('${student.nome} (RA: ${student.ra})'),
                    );
                  }).toList(),
                  onChanged: _onStudentSelected,
                ),
        ),
        if (_selectedStudent != null) ...[
          const SizedBox(height: 16),
          if (_isLoadingGrades)
            const AppCard(
                title: 'Carregando...',
                child: Center(child: CircularProgressIndicator()))
          else
            _buildGradesEditor(),
        ],
      ],
    );
  }

  Widget _buildGradesEditor() {
    if (_professorSubjectsForStudent.isEmpty) {
      return AppCard(
        title: 'Lançar Notas - ${_selectedStudent!.nome}',
        child: const EmptyState(
            'Nenhuma matéria para lecionar encontrada para este aluno.'),
      );
    }

    return AppCard(
      title: 'Lançar Notas - ${_selectedStudent!.nome}',
      icon: Icons.edit_note,
      child: Column(
        children: [
          ..._professorSubjectsForStudent.map((enrollment) {
            final discId = enrollment.disciplinaId;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(enrollment.disciplinaNome,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              'P1', _controllers[discId]!['p1']!)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _buildTextField(
                              'P2', _controllers[discId]!['p2']!)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _buildTextField('Trabalhos',
                              _controllers[discId]!['trabalhos']!)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _buildTextField(
                              'Faltas', _controllers[discId]!['faltas']!)),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 16),
          FilledButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Salvar Notas'),
            onPressed: _saveGrades,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
