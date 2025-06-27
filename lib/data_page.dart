import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'base_page.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<Map<String, dynamic>> feiertage = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse('https://feiertage-api.de/api/?jahr=2025&nur_land=BY');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final List<Map<String, dynamic>> list = data.entries.map((entry) {
          final date = DateTime.tryParse(entry.value['datum']);
          return {
            "name": entry.key,
            "datum": entry.value['datum'],
            "monat": date?.month ?? 0,
            "hinweis": entry.value['hinweis'] ?? "",
            "wert": (date?.month ?? 0).toDouble()
          };
        }).take(5).toList();

        setState(() {
          feiertage = list;
        });
      } else {
        throw Exception('Fehler beim Abrufen der Daten: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Fehler: $e');
      setState(() {
        feiertage = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: feiertage.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade100),
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Datum')),
                  DataColumn(label: Text('Monat')),
                  DataColumn(label: Text('Hinweis')),
                  DataColumn(label: Text('Wert')),
                ],
                rows: feiertage.map((eintrag) {
                  return DataRow(cells: [
                    DataCell(Text(eintrag['name'])),
                    DataCell(Text(eintrag['datum'])),
                    DataCell(Text(eintrag['monat'].toString())),
                    DataCell(Text(eintrag['hinweis'].isEmpty ? '-' : eintrag['hinweis'])),
                    DataCell(Text(eintrag['wert'].toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
          const VerticalDivider(width: 1, color: Colors.grey),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PieChart(
                PieChartData(
                  sections: feiertage.map((eintrag) {
                    return PieChartSectionData(
                      title: eintrag['name'],
                      value: eintrag['wert'],
                      color: Colors.primaries[feiertage.indexOf(eintrag) % Colors.primaries.length],
                      radius: 80,
                      titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    );
                  }).toList(),
                  sectionsSpace: 4,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}