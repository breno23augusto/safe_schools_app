import 'package:flutter/material.dart';
import 'package:safe_schools/src/schools/school.dart';
import 'package:safe_schools/src/schools/school_form_page.dart';
import 'package:safe_schools/src/schools/schools_repository.dart';

import '../shared/components/app_scaffold.dart';

class SchoolsListPage extends StatefulWidget {
  const SchoolsListPage({super.key});

  @override
  _SchoolsListPageState createState() => _SchoolsListPageState();
}

class _SchoolsListPageState extends State<SchoolsListPage> {
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
  late Future<List<School>> _schools;

  @override
  void initState() {
    super.initState();
    _schools = fetchSchools();
  }

  Future<List<School>> fetchSchools() async {
    try {
      final schools = await SchoolsRepository().getSchools();

      setState(() {
        _schools = schools as Future<List<School>>;
      });
    } catch (e) {
      throw Exception(e);
    }
    throw Exception('teste');
  }

  // void loadMore() {
  //   setState(() {
  //     if ((present + perPage) > originalItems.length) {
  //       schools.addAll(originalItems.getRange(present, originalItems.length));
  //     } else {
  //       schools.addAll(originalItems.getRange(present, present + perPage));
  //     }
  //     present = present + perPage;
  //   });
  // }
  //

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
            //hoverElevation: 50,
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

  Widget _buildSchoolsList() => FutureBuilder<List<School>>(
      future: _schools,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(children: [
            CircularProgressIndicator(),
          ]);
        } else if (snapshot.hasError) {
          return Column(children: [
            Center(
              child: Text('Algo inesperado aconteceu: ${snapshot.error}'),
            )
          ]);
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Column(children: [
            Center(child: Text('No schools found.')),
          ]);
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final school = snapshot.data![index + 1];
              return ListTile(
                title: Text(school.name + school.city + school.state),
                subtitle: Text(school.state),
              );
            },
          );
        }
      });
}

class Children {}
