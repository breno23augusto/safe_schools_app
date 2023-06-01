import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
<<<<<<< HEAD

//import 'package:safe_schools/src/shared/components/app_drawer.dart';
//import 'package:safe_schools/src/shared/components/app_scaffold.dart';
=======
<<<<<<< HEAD
<<<<<<< HEAD

//import 'package:safe_schools/src/shared/components/app_drawer.dart';
//import 'package:safe_schools/src/shared/components/app_scaffold.dart';
=======
>>>>>>> f56d88e89f7600e6dc9958a27dc3e8ff7b8ca82c
=======
>>>>>>> f56d88e89f7600e6dc9958a27dc3e8ff7b8ca82c
>>>>>>> e2bee7d18242208930da76fe2d71cc7d7b20dd58

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/src/assets/images/escola.png',
              fit: BoxFit.cover,
              height: 40,
            ),
            const Text(
              'Escolas Seguras',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormItems(
              userName: userName,
              password: password,
              authService: authService,
            ),
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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(50.0),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "O Aplicativo Escola Segura trata-se de uma iniciativa do IFGoiano para mitigar os efeitos devastadores causados pelos ataques a escolas. \n A proposta central é trazer mais segurança e integrar a comunidade a escola com a forças de segurança. \n Este trabalho é um complemento as ações delimitadas pelo governo do estado.",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          TextFormField(
            controller: userName,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 0.5,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Usuário',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  width: 0.5,
                  style: BorderStyle.none,
                  color: Colors.white,
                ),
              ),
              hintText: 'Senha',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
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
                  authService.login(userName.text, password.text).then(
                    (value) {
                      if (value == true) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth/registration');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Registrar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ]);
  }
}
