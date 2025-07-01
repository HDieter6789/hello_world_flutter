import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'data_page.dart';
import 'favorites_page.dart';
import 'map_page.dart';
import 'notifications_page.dart';
import 'chat_page.dart';
import 'base_page.dart';
import 'notifications_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationsProvider = NotificationsProvider();
  await notificationsProvider.loadCommitCount();
  await notificationsProvider.loadBadge();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => notificationsProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Demo App',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: themeProvider.fontSize),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: themeProvider.fontSize),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MyHomePage(),
    FavoritesPage(),
    DataPage(),
    NotificationsPage(),
    MapPage(),
    ChatPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue.shade800,
            unselectedItemColor: Colors.blue.shade200,
            showUnselectedLabels: true,
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
              const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoriten'),
              const BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'Daten'),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.notifications),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Consumer<NotificationsProvider>(
                        builder: (_, provider, __) {
                          if (provider.badgeCount == 0) return const SizedBox.shrink();
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                            child: Text(
                              '${provider.badgeCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                label: 'Mitteilungen',
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
              const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _onMenuSelect(BuildContext context, String value) {
    final navigatorState = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (value == 'Einstellungen') {
      showDialog(
        context: context,
        builder: (_) => const SettingsPopup(),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 300,
            height: 200,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Hello World',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => navigatorState.pop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.blue),
          onSelected: (value) => _onMenuSelect(context, value),
          itemBuilder: (BuildContext context) {
            return ['Service', 'Einstellungen', 'Version', 'Profil'].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Logo HOT GMBH.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 40),
            const Text(
              'Willkommen zur Demo App!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPopup extends StatelessWidget {
  const SettingsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Einstellungen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (bool value) => themeProvider.toggleTheme(value),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: _fontSizeLabel(themeProvider.fontSize),
              items: ['Klein', 'Mittel', 'Groß'].map((String size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text('Schriftgröße: $size'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  themeProvider.setFontSize(value);
                }
              },
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text('Schließen'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fontSizeLabel(double fontSize) {
    if (fontSize <= 14) return 'Klein';
    if (fontSize >= 20) return 'Groß';
    return 'Mittel';
  }
}
