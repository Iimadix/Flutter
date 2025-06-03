import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Supabase.initialize(
    url: 'https://ofpxoqkrihguysmzlhlm.supabase.co',  
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9mcHhvcWtyaWhndXlzbXpsaGxtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2NDk3MzQsImV4cCI6MjA2MTIyNTczNH0.KNb3V-c5bQRj4Y7ALcAuUfWKLGkALs4ig4mCC5R0euc',              // <-- сюда ваш Public API Key
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Регистрация',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _signUp(BuildContext context) async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  final supabase = Supabase.instance.client;

  try {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Регистрация успешна: ${response.user?.email}')),
    );
  } catch (error) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ошибка: $error')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signUp(context),
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}