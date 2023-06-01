import 'package:flutter/material.dart';
import 'package:safe_schools/src/complaint/complaint_repository.dart';
import 'package:safe_schools/src/complaint/entities/complaint.dart';
import 'package:safe_schools/src/shared/components/app_scaffold.dart';
import 'package:safe_schools/src/shared/enums/states.dart';
import 'package:safe_schools/src/shared/repositories/school_repository.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<ComplaintPage> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: 'Denúncia',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SignUpComplaint(),
      ),
    );
  }
}

class SignUpComplaint extends StatefulWidget {
  const SignUpComplaint({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpComplaint> {
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<int>> schoolList = [];
  List<DropdownMenuItem<String>> stateList = States.values.map((States state) {
    return DropdownMenuItem<String>(
      value: state.toString(),
      child: Text(state.name),
    );
  }).toList();

  int _selectedState = 0;
  int? _selectedSchool;
  bool _anonymousMode = false;

  //gera Controller para coletar dados da descrição.
  final description = TextEditingController();

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
      Row(
        children: const [
          Icon(Icons.location_on),
          SizedBox(width: 8),
          Text(
            'Estado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 5),
        child: DropdownButtonFormField<String>(
          hint: const Text('Selecione o Estado'),
          items: stateList,
          onChanged: (value) {
            setState(() {
              _selectedState =
                  stateList.indexWhere((item) => item.value == value);
              States state = States.values.firstWhere(
                  (e) => e.toString() == stateList[_selectedState].value);

              SchoolRepository().index(state).then((value) {
                schoolList = [];

                setState(() {
                  for (int chave in value.keys) {
                    String valor = value[chave]!;
                    print({chave: valor});
                    schoolList.add(
                      DropdownMenuItem(
                        value: chave,
                        child: Text(valor),
                      ),
                    );
                  }
                });
              });
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
          children: const [
            Icon(Icons.house),
            SizedBox(width: 8),
            Text(
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
        child: DropdownButtonFormField<int>(
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
          children: const [
            Icon(Icons.chat_bubble),
            SizedBox(width: 8),
            Text(
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
          controller: description,
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
    // Obtenha o valor do campo descrição
    String? _description = description.text;

    //Enviar de forma anonima? True = sim (Padrão desabilitado) pode ser substituido por 1 ou 0
    formWidget.add(Container(
      margin: const EdgeInsets.only(top: 24),
      child: CheckboxListTile(
        value: _anonymousMode,
        onChanged: (value) {
          setState(() {
            _anonymousMode = value!;
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

        print("Estado: " + _selectedState.toString());
        print("Escola: " + _selectedSchool.toString());
        print("Descrição: " + _description);
        print("Enviado como Anonimo?: " + _anonymousMode.toString());

        ComplaintRepository().store(Complaint(
          schoolId: _selectedSchool!,
          organizationId: 1,
          isAnonymous: _anonymousMode,
          description: _description,
        ));

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(
      Container(
        margin: const EdgeInsets.only(top: 25),
        child: ElevatedButton(
          onPressed: onPressedSubmit, // Chama o método onPressedSubmit
          child: const Text(
            'Enviar',
          ),
        ),
      ),
    );

    return formWidget;
  }
}
