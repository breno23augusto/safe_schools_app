import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safe_schools/src/shared/components/app_scaffold.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<ComplaintPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: 'Denúncia teste',
      child: SignUpComplaint(),
    );
  }
}

class SignUpComplaint extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpComplaint> {
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<int>> destinyList = [];
  List<DropdownMenuItem<String>> stateList = [];
  List<DropdownMenuItem<String>> schoolList = [];

  int _selectedDestiny = 0;
  int _selectedState = 0;
  String? _selectedSchool;

  String _description = '';
  String _maritalStatus = 'single';
  String _localFact = '';

  bool _anonymousMode = false;

//Mapa da Lista de estados ele compara o valor do estado e as escolas dele
//e apresenta no formulário escola
  Map<String, List<String>> stateSchools = {
    'Goiás': [
      'Escola Goiana de Letras',
      'Instituto federal Goiano Campus Catalão',
      'Instituto Margon Vaz'
    ],
    'Minas Gerais': [
      'UFU Campo Santa Monica',
      'Instituto Federal de Uberlandia',
      'Instituto Federal Mineiro'
    ],
  };

  @override
  void initState() {
    super.initState();
    loadDropdownLists();
  }

  void loadDropdownLists() {
    destinyList = [];
    destinyList.add(
      const DropdownMenuItem(
        child: Text('Ministério da Educação'),
        value: 0,
      ),
    );
    destinyList.add(
      const DropdownMenuItem(
        child: Text('Policia Civil'),
        value: 1,
      ),
    );

    stateList = [];
    stateList.add(
      const DropdownMenuItem(
        child: Text('Goiás'),
        value: 'Goiás',
      ),
    );
    stateList.add(
      const DropdownMenuItem(
        child: Text('Minas Gerais'),
        value: 'Minas Gerais',
      ),
    );

    updateSchoolList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: getFormWidget(),
      ),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 8),
            const Text(
              'Destinatário',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 5),
        child: DropdownButtonFormField<int>(
          hint: const Text('Selecione o Orgão'),
          items: destinyList,
          value: _selectedDestiny,
          onChanged: (value) {
            setState(() {
              _selectedDestiny = value!;
            });
          },
          isExpanded: true,
        ),
      ),
    );
    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 35),
        child: Row(
          children: [
            const Icon(Icons.location_on),
            const SizedBox(width: 8),
            const Text(
              'Estado',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 5),
        child: DropdownButtonFormField<String>(
          hint: const Text('Selecione o Estado'),
          items: stateList,
          value: stateList[_selectedState].value,
          onChanged: (value) {
            setState(() {
              _selectedState =
                  stateList.indexWhere((item) => item.value == value);
              updateSchoolList();
            });
          },
          isExpanded: true,
        ),
      ),
    );
    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 35),
        child: Row(
          children: [
            const Icon(Icons.house),
            const SizedBox(width: 8),
            const Text(
              'Escola',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 5),
        child: DropdownButtonFormField<String>(
          hint: const Text('Escola'),
          items: schoolList,
          value: _selectedSchool,
          onChanged: (value) {
            setState(() {
              _selectedSchool = value;
            });
          },
          isExpanded: true,
        ),
      ),
    );
    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 25),
        child: Row(
          children: [
            const Icon(Icons.chat_bubble),
            const SizedBox(width: 8),
            const Text(
              'Descrição',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 12),
        child: TextFormField(
          keyboardType: TextInputType.text,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Digite aqui',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
        ),
      ),
    );

    //Enviar de forma anonima? True = sim (Padrão desabilitado)
    formWidget.add(Container(
      margin: const EdgeInsets.only(top: 24),
      child: CheckboxListTile(
        value: _anonymousMode,
        onChanged: (value) {
          setState(() {
            _anonymousMode = value.toString().toLowerCase() == 'true';
          });
        },
        title: const Text(
          'Enviar de forma Anônima?',
          style: TextStyle(fontSize: 16.0),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    ));
    void onPressedSubmit() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        print("Destinatário: " + _selectedDestiny.toString());
        print("Estado: " + _selectedState.toString());
        print("Escola: " + _selectedSchool.toString());
        print("Descrição: " + _description);
        print("Enviado como Anonimo?: " + _anonymousMode.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 25),
        child: ElevatedButton(
          onPressed: onPressedSubmit, // Chama o método onPressedSubmit
          child: Text(
            'Enviar',
          ),
        ),
      ),
    );

    return formWidget;
  }

  void updateSchoolList() {
    setState(() {
      schoolList = stateSchools[stateList[_selectedState].value]!
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
      _selectedSchool = schoolList.isNotEmpty ? schoolList[0].value : null;
    });
  }
}
