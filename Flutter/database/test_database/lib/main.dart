import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('💬 Фоновое сообщение: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBNnRJknHIxUHDrqloRinz_j3kRMRHo2KQ",
      appId: "1:262898323986:web:ed05ab88b06be98858fecb",
      messagingSenderId: "262898323986",
      projectId: "testproject-ee7d9",
      storageBucket: "testproject-ee7d9.appspot.com",
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _token = "Получаем токен...";

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        _token = token;
      });
      print('📲 FCM токен: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔔 Foreground PUSH!');
      if (message.notification != null) {
        final title = message.notification!.title ?? '';
        final body = message.notification!.body ?? '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('🔔 $title: $body')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = FirebaseFirestore.instance.collection('users');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Пользователи")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SelectableText("FCM токен:\n$_token", style: TextStyle(fontSize: 12)),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Ошибка: ${snapshot.error}');
                  if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());

                  final data = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(user['name'] ?? 'Без имени'),
                        subtitle: Text('Возраст: ${user['age'] ?? '?'}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
