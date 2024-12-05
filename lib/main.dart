import 'package:daphstore_app/screens/home_screen.dart';
import 'package:daphstore_app/screens/login_screen.dart';
import 'package:daphstore_app/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'utils/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child:
        const MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Variável para alternar entre temas

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
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Alterna os temas
      debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      // home: LoginScreen(
      //   onThemeChanged: _toggleTheme, // Passa o método de alternância para a tela de login
      // ),
    );
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode; // Alterna o modo de tema
    });
  }

}
