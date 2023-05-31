import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_schools/src/schools/school.dart';
import 'package:safe_schools/src/schools/schools_repository.dart';

import '../shared/enums/states.dart';

class SchoolFormPage extends StatefulWidget {
  final School? school;

  const SchoolFormPage({super.key, this.school});

  @override
  // ignore: library_private_types_in_public_api
  _SchoolFormPageState createState() => _SchoolFormPageState();
}

class _SchoolFormPageState extends State<SchoolFormPage> {
  final _formKey = GlobalKey<FormState>();

  States? selectedState;
  List<DropdownMenuItem<States>>? _stateDropdownItems;

  late int _id;
  late TextEditingController _nameController;
  late TextEditingController _streetController;
  late TextEditingController _numberController;
  late TextEditingController _neighborhoodController;
  late TextEditingController _complementController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;

  @override
  void initState() {
    super.initState();
    _id = widget.school?.id ?? 0;
    _nameController = TextEditingController(text: widget.school?.name ?? '');
    _streetController =
        TextEditingController(text: widget.school?.street ?? '');
    _numberController =
        TextEditingController(text: widget.school?.number ?? '');
    _neighborhoodController =
        TextEditingController(text: widget.school?.neighborhood ?? '');
    _complementController =
        TextEditingController(text: widget.school?.complement ?? '');
    _cityController = TextEditingController(text: widget.school?.city ?? '');
    _stateController = TextEditingController(text: widget.school?.state ?? '');

    _stateDropdownItems = States.values.map((state) {
      return DropdownMenuItem<States>(
        value: state,
        child: Text(state.toString().split('.').last),
      );
    }).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _neighborhoodController.dispose();
    _complementController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final School school = School(
        id: _id,
        name: _nameController.text,
        street: _streetController.text,
        number: _numberController.text,
        neighborhood: _neighborhoodController.text,
        complement: _complementController.text,
        city: _cityController.text,
        state: _stateController.text.split('.').last,
      );

      try {
        if (_id == 0) {
          await SchoolsRepository().createSchool(school);
        } else {
          await SchoolsRepository().updateSchool(school);
        }
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Escola salva com sucesso.')),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/schools/list');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de escola'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatorio!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Rua'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatorio!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatorio!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _neighborhoodController,
                decoration: const InputDecoration(labelText: 'Bairro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatorio!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _complementController,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatorio!';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<States>(
                value: selectedState,
                items: _stateDropdownItems,
                onChanged: (selectedValue) {
                  setState(() {
                    selectedState = selectedValue;
                    _stateController.text = selectedValue.toString();
                  });
                },
                validator: (state) {
                  if (state == null) {
                    return 'Campo Obrigatorio!';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
