import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
import 'package:safe_schools/src/shared/components/app_drawer.dart';
import 'package:safe_schools/src/shared/components/app_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.user == null) {
        authService.hasToken().then((value) {
          if (value == true) {
            authService.initUser().then((_) {
              if (authService.user != null) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolas Seguras'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormItems(
            userName: userName,
            password: password,
            authService: authService,
          ),
        ),
      ),
    );
  }
}

class FormItems extends StatelessWidget {
  const FormItems({
    super.key,
    required this.userName,
    required this.password,
    required this.authService,
  });

  final TextEditingController userName;
  final TextEditingController password;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        controller: userName,
        decoration: const InputDecoration(hintText: 'usuário'),
      ),
      const SizedBox(
        height: 8.0,
      ),
      TextFormField(
        controller: password,
        decoration: const InputDecoration(hintText: 'senha'),
        obscureText: true,
      ),
      const SizedBox(
        height: 8.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              authService.login(userName.text, password.text).then((value) {
                if (value == true) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                }
              });
            },
            child: const Text('entrar'),
          ),
          const SizedBox(
            width: 8.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/auth/registration');
            },
            child: const Text('registrar'),
          ),
        ],
      )
    ]);
  }
}
