import 'package:flutter/material.dart';
import 'package:safe_schools/src/shared/components/app_scaffold.dart';

class PanelPage extends StatelessWidget {
  var item = ['2023', '2024', '2025'];
  final dropValue = ValueNotifier('');
  final currentYear = '2023';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: "Painel",
      child: ListView(
        children: [
          Container(
              margin: const EdgeInsets.all(10.0), child: TableCriticality()),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(25.0),
                child: Text('Denúncias no Ano de:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
              DropdownButton(
                  items: item.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (escolha) => dropValue.value = escolha.toString()),
            ],
          ),
          Container(
              margin: const EdgeInsets.all(10.0), child: TablePerPeriod()),
        ],
      ),
    );
  }
}

class TableCriticality extends StatelessWidget {
  const TableCriticality({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Criticidade',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Quantidade de denúncias',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Icon(
              Icons.rectangle_rounded,
              color: Colors.red,
            )),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Icon(
              Icons.rectangle_rounded,
              color: Colors.orange,
            )),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Icon(
              Icons.rectangle_rounded,
              color: Colors.yellow,
            )),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Icon(
              Icons.rectangle_rounded,
              color: Colors.green,
            )),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Icon(
              Icons.rectangle_rounded,
              color: Colors.blue,
            )),
            DataCell(Text('100')),
          ],
        ),
      ],
    );
  }
}

class TablePerPeriod extends StatelessWidget {
  const TablePerPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Mês',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Quantidade de denúncias',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janeiro')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Fevereiro')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Março')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Abril')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Maio')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Junho')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Julho')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Agosto')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Setembro')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Outubro')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Novembro')),
            DataCell(Text('100')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Dezembro')),
            DataCell(Text('100')),
          ],
        ),
      ],
    );
  }
}
