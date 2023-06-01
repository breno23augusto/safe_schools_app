import 'package:flutter/material.dart';
import 'package:safe_schools/src/panel/repositories/reports_repository.dart';
import 'package:safe_schools/src/shared/components/app_scaffold.dart';

class PanelPage extends StatefulWidget {
  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> {
  final ReportsRepository repository = ReportsRepository();
  final dropValue = ValueNotifier('');
  final currentYear = DateTime.now().year.toString();
  int selectedYear = DateTime.now().year;

  List<DataRow> apcWidgetList = [];
  List<DataRow> apmWidgetList = [];
  List<DataRow> apsWidgetList = [];

  @override
  initState() {
    setState(() {
      apcWidgetList = [];
      apmWidgetList = [];
      apsWidgetList = [];

      repository.amountPerClassification(selectedYear).then((value) {
        setState(() {
          apcWidgetList = mapApcList(value);
        });
      });

      repository.amountPerMonth(selectedYear).then((value) {
        setState(() {
          apmWidgetList = mapApmList(value);
        });
      });

      repository.amountPerSchool(selectedYear).then((value) {
        setState(() {
          apsWidgetList = mapApsList(value);
        });
      });
    });
  }

  List<int> getYearRange() {
    const int startYear = 2000;
    const int endYear = 2100;
    final List<int> yearList = [];

    for (int year = startYear; year <= endYear; year++) {
      yearList.add(year);
    }

    return yearList;
  }

  List<DataRow> mapApcList(
      List<AmountPerClassification> amountPerClassificationList) {
    Map<String, MaterialColor> colors = {
      "vermelho": Colors.red,
      "laranja": Colors.orange,
      "amarelo": Colors.yellow,
      "verde": Colors.green,
      "azul": Colors.blue,
      "default": Colors.grey,
    };

    List<DataRow> output = [];
    for (var element in amountPerClassificationList) {
      output.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Icon(
                Icons.rectangle_rounded,
                color: colors[element.classification],
              ),
            ),
            DataCell(Text(element.total.toString())),
          ],
        ),
      );
    }

    return output;
  }

  List<DataRow> mapApmList(List<AmountPerMonth> amountsPerMonth) {
    List<DataRow> output = [];
    for (var element in amountsPerMonth) {
      output.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.month)),
            DataCell(Text(element.total.toString())),
          ],
        ),
      );
    }

    return output;
  }

  List<DataRow> mapApsList(List<AmountPerSchool> amountsPerSchool) {
    List<DataRow> output = [];
    for (var element in amountsPerSchool) {
      output.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.school)),
            DataCell(Text(element.total.toString())),
          ],
        ),
      );
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      pageTitle: "Painel",
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                const Text(
                  'Denúncias no Ano de:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton(
                  items: getYearRange().map((int dropDownStringItem) {
                    return DropdownMenuItem<int>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem.toString(),
                      ),
                    );
                  }).toList(),
                  value: selectedYear,
                  onChanged: (selected) {
                    setState(() {
                      apcWidgetList = [];
                      apmWidgetList = [];
                      apsWidgetList = [];

                      selectedYear = selected!;
                      repository
                          .amountPerClassification(selectedYear)
                          .then((value) {
                        setState(() {
                          apcWidgetList = mapApcList(value);
                        });
                      });

                      repository.amountPerMonth(selectedYear).then((value) {
                        setState(() {
                          apmWidgetList = mapApmList(value);
                        });
                      });

                      repository.amountPerSchool(selectedYear).then((value) {
                        setState(() {
                          apsWidgetList = mapApsList(value);
                        });
                      });
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Denúncias Por Classicação",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TableCriticality(
              apcWidgetList: apcWidgetList,
            ),
            const SizedBox(height: 8),
            const Text(
              "Denúncias Por Período",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TablePerPeriod(apmWidgetList: apmWidgetList),
            const SizedBox(height: 8),
            const Text(
              "Denúncias Por Escolas",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TablePerSchool(apsWidgetList: apsWidgetList),
          ],
        ),
      ),
    );
  }
}

class TableCriticality extends StatelessWidget {
  List<DataRow> apcWidgetList;
  TableCriticality({
    super.key,
    required this.apcWidgetList,
  });

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
              'Qtd.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: apcWidgetList,
    );
  }
}

class TablePerPeriod extends StatelessWidget {
  List<DataRow> apmWidgetList = [];
  TablePerPeriod({super.key, required this.apmWidgetList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Mês',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Qtd.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
      rows: apmWidgetList,
    );
  }
}

class TablePerSchool extends StatelessWidget {
  List<DataRow> apsWidgetList = [];
  TablePerSchool({super.key, required this.apsWidgetList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Escola',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Qtd.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
      rows: apsWidgetList,
    );
  }
}
