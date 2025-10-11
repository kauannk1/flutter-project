import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'pages/auth/login_page.dart';
import 'pages/home/home_page.dart';
import 'services/firestore_service.dart';
import 'models/user_profile.dart';
import 'providers/theme_provider.dart';

class PortalAlunoApp extends StatelessWidget {
  const PortalAlunoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xFF2C3E50),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3498db),
        brightness: Brightness.dark,
        background: const Color(0xFF121212),
        surface: const Color(0xFF1E1E1E),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme,
      ),
    );

    return MaterialApp(
      title: 'Portal do Aluno',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const _AuthGate(),
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate({super.key});

  Future<UserProfile> _getOrCreateUserProfile(User user) async {
    final firestoreService = FirestoreService();
    UserProfile? profile = await firestoreService.getUserProfile(user.uid);

    if (profile == null) {
      final email = user.email?.toLowerCase() ?? '';
      final String papel =
          email.endsWith('-prof@fatec.com') ? 'professor' : 'aluno';

      profile = UserProfile(
        uid: user.uid,
        email: user.email!,
        nome: user.displayName ?? user.email!.split('@').first,
        papel: papel,
        semestreAtual: papel == 'aluno' ? 1 : null,
        gradeId: papel == 'aluno' ? 'ads_2025_diurno' : null,
      );

      await firestoreService.saveUserProfile(profile);
    }

    return profile;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        final user = snapshot.data;

        if (user != null) {
          return FutureProvider<UserProfile?>(
            create: (_) => _getOrCreateUserProfile(user),
            initialData: null,
            child: Consumer<UserProfile?>(
              builder: (context, profile, child) {
                if (profile == null) {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }

                return Provider<UserProfile>.value(
                  value: profile,
                  child: const HomePage(),
                );
              },
            ),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
