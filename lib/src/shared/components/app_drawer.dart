import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
import 'package:safe_schools/src/shared/helpers/string_helpers.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  child: Text(
                    authService.user?.name[0] ?? '-',
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  StringHelpers.truncateWithEllipsis(
                    15,
                    authService.user?.name ?? '-',
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .popUntil((route) => !Navigator.of(context).canPop());
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Denúncias'),
            onTap: () {
              Navigator.of(context)
                  .popUntil((route) => !Navigator.of(context).canPop());
              Navigator.popAndPushNamed(context, '/complaint');
            },
          ),
          ListTile(
            title: const Text('Painel'),
            onTap: () {
              Navigator.of(context)
                  .popUntil((route) => !Navigator.of(context).canPop());
              Navigator.popAndPushNamed(context, '/panel');
            },
          ),
          ListTile(
            title: const Text('Escolas'),
            onTap: () {
              Navigator.pushNamed(context, '/schools/list');
            },
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
              authService.logout().then((value) {
                Navigator.of(context)
                    .popUntil((route) => !Navigator.of(context).canPop());
                Navigator.of(context).popAndPushNamed('/auth/login');
              });
            },
          ),
        ],
      ),
    );
  }
}
