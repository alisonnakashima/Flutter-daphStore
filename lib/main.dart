import 'package:daphstore_app/screens/home_screen.dart';
import 'package:daphstore_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Variável para alternar entre temas

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DaphStore App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        primaryColor: const Color.fromARGB(255, 255, 100, 110),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        primaryColor: const Color.fromARGB(255, 80, 80, 120),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light, // Alterna os temas
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // home: LoginScreen(
      //   onThemeChanged: _toggleTheme, // Passa o método de alternância para a tela de login
      // ),
    );
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Alterna o modo de tema
    });
  }
}
