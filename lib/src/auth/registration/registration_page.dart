<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
import 'package:safe_schools/src/auth/registration/registration_repository.dart';

import 'entities/registration.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Conta',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
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
      padding: const EdgeInsets.fromLTRB(6, 6, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: userName,
            decoration: const InputDecoration(
                hintText: 'Usuário', icon: Icon(Icons.person_outline)),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(
                hintText: 'Senha', icon: Icon(Icons.password_outlined)),
            obscureText: true,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
                hintText: 'Email', icon: Icon(Icons.email_outlined)),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12.0),
              ElevatedButton(
                  onPressed: () async {
                    var registrationResponse =
                        await RegistrationRepository().store(
                      Registration(
                        email: email.text,
                        password: password.text,
                        name: userName.text,
                      ),
                    );

                    if (registrationResponse.error) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: Container(
                              padding: const EdgeInsets.all(12),
                              height: 90,
                              decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(22))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Houve um erro',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  Text(
                                    registrationResponse.reason,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ))));
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/auth/login');
                    }
                  },
                  style: const ButtonStyle(),
                  child: const Text('Criar conta')),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth/login');
                },
                child: const Text(
                  'Já tem conta? Fazer login!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
import 'package:safe_schools/src/auth/registration/registration_repository.dart';

import 'entities/registration.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Conta',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
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
      padding: const EdgeInsets.fromLTRB(6, 6, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: userName,
            decoration: const InputDecoration(
                hintText: 'Usuário', icon: Icon(Icons.person_outline)),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(
                hintText: 'Senha', icon: Icon(Icons.password_outlined)),
            obscureText: true,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
                hintText: 'Email', icon: Icon(Icons.email_outlined)),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12.0),
              ElevatedButton(
                  onPressed: () async {
                    var registrationResponse =
                        await RegistrationRepository().store(
                      Registration(
                        email: email.text,
                        password: password.text,
                        name: userName.text,
                      ),
                    );

                    if (registrationResponse.error) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: Container(
                              padding: const EdgeInsets.all(12),
                              height: 90,
                              decoration: BoxDecoration(
                                  color: Colors.red[600],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(22))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Houve um erro',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  Text(
                                    registrationResponse.reason,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ))));
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/auth/login');
                    }
                  },
                  style: const ButtonStyle(),
                  child: const Text('Criar conta')),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth/login');
                },
                child: const Text(
                  'Já tem conta? Fazer login!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
>>>>>>> f56d88e89f7600e6dc9958a27dc3e8ff7b8ca82c
