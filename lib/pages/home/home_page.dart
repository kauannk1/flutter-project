import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_profile.dart';
import '../../widgets/avatar.dart';
import 'tabs/inicio_tab.dart';
import 'tabs/horario_tab.dart';
import 'tabs/atividades_tab.dart';
import 'tabs/notas_tab.dart';
import 'tabs/calendario_tab.dart';
import 'tabs/curso_tab.dart';
import 'tabs/config_tab.dart';
import 'tabs/professor_avisos_tab.dart';
import 'tabs/professor_notas_tab.dart';

class AppPage {
  final String title;
  final Widget child;
  final IconData icon;

  const AppPage({required this.title, required this.child, required this.icon});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de todas as páginas possíveis no aplicativo
  late final List<AppPage> _allPages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProfile = Provider.of<UserProfile>(context);
    final isProfessor = userProfile.papel == 'professor';

    _allPages = [
      const AppPage(
          title: 'Início', child: InicioTab(), icon: Icons.home_outlined),
      const AppPage(
          title: 'Horário', child: HorarioTab(), icon: Icons.schedule_outlined),
      const AppPage(
          title: 'Atividades',
          child: AtividadesTab(),
          icon: Icons.checklist_outlined),
      const AppPage(
          title: 'Notas', child: NotasTab(), icon: Icons.school_outlined),
      const AppPage(
          title: 'Calendário',
          child: CalendarioTab(),
          icon: Icons.calendar_month_outlined),
      const AppPage(
          title: 'Meu Curso',
          child: CursoTab(),
          icon: Icons.menu_book_outlined),
      const AppPage(
          title: 'Configurações',
          child: ConfigTab(),
          icon: Icons.settings_outlined),
      if (isProfessor)
        const AppPage(
            title: 'Lançar Notas',
            child: ProfessorNotasTab(),
            icon: Icons.edit_note),
      if (isProfessor)
        const AppPage(
            title: 'Gerenciar Avisos',
            child: ProfessorAvisosTab(),
            icon: Icons.campaign_outlined),
    ];
  }

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // quais páginas vão para a barra inferior e quais vão para o menu
    final bottomNavPages = _allPages.take(3).toList();
    final drawerPages = _allPages.skip(3).toList();

    // Ajusta o índice se a seleção atual estiver no menu lateral
    final isDrawerSelection = _selectedIndex >= bottomNavPages.length;

    return Scaffold(
      // AppBar para o título e o botão do menu
      appBar: AppBar(
        title: Text(_allPages[_selectedIndex].title),
        elevation: 1,
      ),
      // corpo do Scaffold, que é a página selecionada
      body: IndexedStack(
        index: _selectedIndex,
        children: _allPages.map((p) => p.child).toList(),
      ),
      // Menu Lateral (Drawer)
      drawer: AppDrawer(
        allPages: _allPages,
        drawerPages: drawerPages,
        selectedIndex: _selectedIndex,
        onNavigate: _navigateTo,
      ),
      // BottomNavigationBar tem os itens principais
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: isDrawerSelection ? 0 : _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: bottomNavPages.map((p) {
          return BottomNavigationBarItem(icon: Icon(p.icon), label: p.title);
        }).toList(),
      ),
    );
  }
}

// Widget para Menu Lateral
class AppDrawer extends StatelessWidget {
  final List<AppPage> allPages;
  final List<AppPage> drawerPages;
  final int selectedIndex;
  final ValueChanged<int> onNavigate;

  const AppDrawer({
    super.key,
    required this.allPages,
    required this.drawerPages,
    required this.selectedIndex,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final userProfile = context.watch<UserProfile>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Cabeçalho do Menu
          UserAccountsDrawerHeader(
            accountName: Text(userProfile.nome ?? 'Aluno',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text(userProfile.email),
            currentAccountPicture: Avatar(url: userProfile.fotoUrl, size: 72),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          // Itens do menu
          ...drawerPages.map((page) {
            final index = allPages.indexOf(page);
            return ListTile(
              leading: Icon(page.icon),
              title: Text(page.title),
              selected: selectedIndex == index,
              onTap: () => onNavigate(index),
              selectedTileColor: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.3),
            );
          }),
        ],
      ),
    );
  }
}
