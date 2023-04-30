import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
import 'package:safe_schools/src/auth/login_page.dart';
import 'package:safe_schools/src/auth/registraion_page.dart';
import 'package:safe_schools/src/home/home_page.dart';
import 'package:safe_schools/src/shared/themes/color_schemes.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: _app(),
    );
  }

  Widget _app() {
    return MaterialApp(
      title: 'Escolas Seguras',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      initialRoute: '/auth/login',
      routes: {
        '/auth/login': (context) => const LoginPage(),
        '/auth/registration': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
