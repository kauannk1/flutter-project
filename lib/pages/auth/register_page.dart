import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final raController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController =
      TextEditingController(); // controller da confirmação
  final semestreController = TextEditingController();
  final telefoneController = TextEditingController(); // controller do telefone

  String? _selectedCurso;
  String? _selectedTurno;

  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta de Aluno')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        // uso um form pra validar tudo
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome completo'),
                  validator: (value) =>
                      value!.isEmpty ? 'campo obrigatório' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: raController,
                  decoration: const InputDecoration(labelText: 'RA'),
                  validator: (value) =>
                      value!.isEmpty ? 'campo obrigatório' : null,
                ),
                const SizedBox(height: 12),
                // campo de telefone
                TextFormField(
                  controller: telefoneController,
                  decoration:
                      const InputDecoration(labelText: 'Telefone (opcional)'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _selectedCurso,
                  hint: const Text('Curso'),
                  items: const [
                    DropdownMenuItem(
                        value: 'ads',
                        child: Text('Análise e Des. de Sistemas')),
                  ],
                  onChanged: (value) => setState(() => _selectedCurso = value),
                  validator: (value) =>
                      value == null ? 'selecione um curso' : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedTurno,
                        hint: const Text('Turno'),
                        items: const [
                          DropdownMenuItem(
                              value: 'diurno', child: Text('Diurno')),
                          DropdownMenuItem(
                              value: 'noturno', child: Text('Noturno')),
                        ],
                        onChanged: (value) =>
                            setState(() => _selectedTurno = value),
                        validator: (value) =>
                            value == null ? 'selecione um turno' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: semestreController,
                        decoration:
                            const InputDecoration(labelText: 'Semestre Atual'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'obrigatório';
                          final n = int.tryParse(value);
                          if (n == null || n < 1 || n > 6) return '1-6';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isEmpty ? 'campo obrigatório' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (value) =>
                      (value?.length ?? 0) < 6 ? 'mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 12),
                // campo de confirmar senha
                TextFormField(
                  controller: confirmaSenhaController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  // validação pra ver se as senhas batem
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'campo obrigatório';
                    if (value != senhaController.text)
                      return 'as senhas não coincidem';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center),
                  ),
                FilledButton(
                  onPressed: loading ? null : _register,
                  style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12)),
                  child: loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
      error = null;
    });

    try {
      await AuthService().register(
        email: emailController.text.trim(),
        password: senhaController.text,
        nome: nomeController.text.trim(),
        ra: raController.text.trim(),
        curso: _selectedCurso!,
        turno: _selectedTurno!,
        semestre: int.parse(semestreController.text),
        telefone: telefoneController.text.trim(),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) setState(() => error = 'erro no cadastro: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }
}
