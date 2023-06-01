import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
import 'package:safe_schools/src/auth/login_page.dart';
import 'package:safe_schools/src/auth/registration/registration_page.dart';
import 'package:safe_schools/src/complaint/complaint_page.dart';
import 'package:safe_schools/src/home/home_page.dart';
import 'package:safe_schools/src/panel/panel_page.dart';
import 'package:safe_schools/src/schools/school_form_page.dart';
import 'package:safe_schools/src/schools/schools_list_page.dart';
import 'package:safe_schools/src/shared/themes/color_schemes.g.dart';

void main() {
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> e2bee7d18242208930da76fe2d71cc7d7b20dd58
  // ignore: prefer_const_constructors
  runApp(MyApp());
=======
  runApp(const MyApp());
>>>>>>> f56d88e89f7600e6dc9958a27dc3e8ff7b8ca82c
=======
  runApp(const MyApp());
>>>>>>> f56d88e89f7600e6dc9958a27dc3e8ff7b8ca82c
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
        '/schools/list': (context) => const SchoolsListPage(),
        '/schools/form': (context) => const SchoolFormPage(),
        '/complaint': (context) => const ComplaintPage(),
        '/panel': (context) => PanelPage(),
      },
    );
  }
}
