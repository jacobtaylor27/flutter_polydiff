import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polydiff/providers/chat_provider.dart';
import 'package:flutter_polydiff/providers/user_provider.dart';
import 'package:flutter_polydiff/screens/signin_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: const MaterialApp(
        home: SignInScreen()
      ),
    );
  }
}