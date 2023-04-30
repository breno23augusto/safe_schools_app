import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_schools/src/auth/auth_service.dart';
import 'package:safe_schools/src/shared/components/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return AppScaffold(
      pageTitle: 'Home',
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(authService.user?.login ?? ''),
        ),
      ),
    );
  }
}
