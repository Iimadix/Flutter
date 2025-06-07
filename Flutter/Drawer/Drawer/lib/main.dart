import 'package:flutter/material.dart';

void main() {
  runApp(const DrawerApp());
}

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePageWithDrawer(),
        '/screen1': (context) => const ScreenOne(),
        '/screen2': (context) => const ScreenTwo(),
        '/screen3': (context) => const ScreenThree(),
      },
    );
  }
}

class HomePageWithDrawer extends StatelessWidget {
  const HomePageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная страница'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Добро пожаловать на главную страницу!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildListTile(context, 'Главная страница', '/', Icons.home),
                _buildListTile(context, 'Экран 1', '/screen1', Icons.looks_one),
                _buildListTile(context, 'Экран 2', '/screen2', Icons.looks_two),
                _buildListTile(context, 'Экран 3', '/screen3', Icons.looks_3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, String title, String route, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран 1'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Содержимое первого экрана',
          style: TextStyle(fontSize: 24, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран 2'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Содержимое второго экрана',
          style: TextStyle(fontSize: 24, color: Colors.green),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран 3'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Содержимое третьего экрана',
          style: TextStyle(fontSize: 24, color: Colors.orange),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
