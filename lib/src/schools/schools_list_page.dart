import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safe_schools/src/schools/school.dart';
import 'package:safe_schools/src/schools/school_form_page.dart';
import 'package:safe_schools/src/schools/schools_repository.dart';

import '../shared/components/app_scaffold.dart';

class SchoolsListPage extends StatefulWidget {
  const SchoolsListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SchoolsListPageState createState() => _SchoolsListPageState();
}

class _SchoolsListPageState extends State<SchoolsListPage> {
  late Future<List<School>> schools;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: 'Listagem de Escola',
      child: Column(
        children: [
          _buildSchoolsList(),
          _floatButton(),
        ],
      ),
    );
  }

  int present = 0;
  int perPage = 15;

  @override
  void initState() {
    super.initState();
    schools = fetchSchools();
  }

  Future<List<School>> fetchSchools() async {
    try {
      schools = SchoolsRepository().getSchools();

      setState(() {
        schools = schools;
      });
      return schools;
    } catch (e) {
      throw Exception(e);
    }
  }

  Widget _floatButton() {
    return Builder(builder: (context) {
      FloatingActionButtonLocation.endDocked;
      return Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SchoolFormPage(),
                  ));
            },
            tooltip: 'Novo',
            shape: const CircleBorder(),
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add,
                color: Colors.white, size: 30, weight: 950),
          ),
        ],
      );
    });
  }

  Future<void> _refreshSchools() async {
    setState(() {
      schools = fetchSchools();
    });
  }

  Widget _buildSchoolsList() {
    return FutureBuilder<List<School>>(
      future: schools,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Center(
                child: Text('Algo inesperado aconteceu: ${snapshot.error}'),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          final schools = snapshot.data!;
          if (schools.isEmpty) {
            return const SingleChildScrollView(
                child: Column(
              children: [
                Center(child: Text('Nenhuma Escola foi encontrada.')),
              ],
            ));
          } else {
            return Expanded(
                child: ListView.builder(
              itemCount: schools.length,
              itemBuilder: (context, index) {
                final school = schools[index];
                return ListTile(
                  title: Text(school.name),
                  subtitle: Text(
                      '${school.street} - ${school.city} - ${school.state}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SchoolFormPage(school: school),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Apagar Escola'),
                              content: const Text(
                                  'Tem certeza de que deseja excluir esta escola?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text('Deletar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    SchoolsRepository()
                                        .deleteSchool(school.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Escola excluida com sucesso.')),
                                    );
                                    _refreshSchools();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ));
          }
        } else {
          return const SizedBox(
            height: 100,
            child: Text('Cadastre uma nova escola'),
          );
        }
      },
    );
  }
}
