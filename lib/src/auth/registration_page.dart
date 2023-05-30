import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: FormItems(
          userName: userName,
          password: password,
          email: email,
          authService: authService),
    );
  }
}

class FormItems extends StatelessWidget {
  final TextEditingController userName;
  final TextEditingController password;
  final TextEditingController email;
  final AuthService authService;

  const FormItems(
      {super.key,
      required this.userName,
      required this.password,
      required this.email,
      required this.authService});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: userName,
            decoration: const InputDecoration(hintText: 'Usuário'),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(hintText: 'Senha'),
            obscureText: true,
          ),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth/login');
                },
                child: const Text('Criar conta'),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth/login');
                },
                child: const Text('Já tem conta? Fazer login!'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
