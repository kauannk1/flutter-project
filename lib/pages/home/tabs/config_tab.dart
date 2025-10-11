import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/avatar.dart';
import '../../../services/cloudinary_service.dart';
import '../../../services/firestore_service.dart';
import '../../../services/auth_service.dart';
import '../../../models/user_profile.dart';
import '../../../pages/home/tabs/about_page.dart';

class ConfigTab extends StatefulWidget {
  const ConfigTab({super.key});

  @override
  State<ConfigTab> createState() => _ConfigTabState();
}

class _ConfigTabState extends State<ConfigTab> {
  String? _fotoUrl;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final userProfile = Provider.of<UserProfile>(context, listen: false);
    _fotoUrl = userProfile.fotoUrl;
  }

  Future<void> _trocarFoto() async {
    final userProfile = context.read<UserProfile>();

    final picker = ImagePicker();
    final img =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img == null || !mounted) return;

    setState(() => _isUploading = true);

    try {
      final bytes = await img.readAsBytes();
      final cloud = CloudinaryService(
          cloudName: 'de6wakqkd', uploadPreset: 'portal_aluno_fotos');
      final url = await cloud.uploadBytes(bytes, fileName: 'perfil.jpg');

      final updatedProfile = userProfile.copyWith(fotoUrl: url);
      await FirestoreService().saveUserProfile(updatedProfile);

      if (mounted) {
        setState(() => _fotoUrl = url);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro no upload: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _signOut() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = context.watch<UserProfile>();
    final themeProvider = context.watch<ThemeProvider>();
    _fotoUrl = userProfile.fotoUrl;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppCard(
          title: 'Perfil',
          icon: Icons.person_outline,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Avatar(url: _fotoUrl, size: 64),
                  if (_isUploading) const CircularProgressIndicator(),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userProfile.nome ?? 'Nome não informado',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('RA: ${userProfile.ra ?? '...'}'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _isUploading ? null : _trocarFoto,
                child: const Text('Trocar foto'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          title: 'Aparência',
          icon: Icons.palette_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Escolha o tema do aplicativo',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              SegmentedButton<ThemeMode>(
                segments: const <ButtonSegment<ThemeMode>>[
                  ButtonSegment<ThemeMode>(
                      value: ThemeMode.light,
                      label: Text('Claro'),
                      icon: Icon(Icons.light_mode_outlined)),
                  ButtonSegment<ThemeMode>(
                      value: ThemeMode.dark,
                      label: Text('Escuro'),
                      icon: Icon(Icons.dark_mode_outlined)),
                  ButtonSegment<ThemeMode>(
                      value: ThemeMode.system,
                      label: Text('Sistema'),
                      icon: Icon(Icons.brightness_auto_outlined)),
                ],
                selected: {themeProvider.themeMode},
                onSelectionChanged: (Set<ThemeMode> newSelection) {
                  context
                      .read<ThemeProvider>()
                      .setThemeMode(newSelection.first);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
            title: 'Conta e Informações',
            icon: Icons.manage_accounts_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Sobre o Aplicativo'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()),
                    );
                  },
                ),
                const Divider(),
                FilledButton.tonal(
                  onPressed: _signOut,
                  child: const Text('Sair da conta'),
                ),
              ],
            )),
      ],
    );
  }
}
