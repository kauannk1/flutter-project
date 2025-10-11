import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  bool loading = false;
  String? feedbackMessage;
  bool isError = false;

  Future<void> _sendResetLink() async {
    if (emailController.text.trim().isEmpty) {
      setState(() {
        feedbackMessage = 'Por favor, insira seu e-mail.';
        isError = true;
      });
      return;
    }

    setState(() {
      loading = true;
      feedbackMessage = null;
    });

    try {
      // verificar se o email existe
      await AuthService().sendPasswordResetEmail(emailController.text.trim());

      setState(() {
        feedbackMessage =
            'Se um e-mail correspondente for encontrado, um link de recuperação será enviado.';
        isError = false;
      });

      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } catch (e) {
      //erros de rede ou formato de e-mail inválido
      setState(() {
        feedbackMessage =
            'Ocorreu um erro. Verifique sua conexão e o formato do e-mail.';
        isError = true;
      });
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Insira o e-mail associado à sua conta e enviaremos um link para redefinir sua senha.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: loading ? null : _sendResetLink,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Enviar Link de Recuperação'),
                ),
                if (feedbackMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    feedbackMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isError ? Colors.red : Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
