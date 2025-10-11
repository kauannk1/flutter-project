import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final senha = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2c3e50),
              Color(0xFF34495e),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo_fatec.png', width: 140),
                const SizedBox(height: 24),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Portal do Aluno',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: const Color(0xFF2c3e50),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                              controller: email,
                              decoration:
                                  const InputDecoration(labelText: 'E-mail')),
                          const SizedBox(height: 12),
                          TextField(
                              controller: senha,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(labelText: 'Senha')),
                          const SizedBox(height: 16),
                          if (error != null)
                            Text(error!,
                                style: const TextStyle(color: Colors.red)),
                          const SizedBox(height: 8),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            onPressed: loading
                                ? null
                                : () async {
                                    setState(() => loading = true);
                                    try {
                                      await AuthService().signIn(
                                          email.text.trim(), senha.text);
                                    } catch (e) {
                                      if (mounted) {
                                        setState(() => error =
                                            'Falha no login: Verifique seu e-mail e senha.');
                                      }
                                    } finally {
                                      if (mounted) {
                                        setState(() => loading = false);
                                      }
                                    }
                                  },
                            child: loading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : const Text('Entrar'),
                          ),

                          // botao de 'Esqueci a Senha'
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordPage(),
                              ),
                            ),
                            child: const Text('Esqueci minha senha'),
                          ),
                          const Divider(),
                          TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const RegisterPage())),
                              child: const Text('Criar conta')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
