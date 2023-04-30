import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safe_schools/src/shared/components/app_scaffold.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: "Reports",
      child: Center(
        child: Text("reportss"),
      ),
    );
  }
}
