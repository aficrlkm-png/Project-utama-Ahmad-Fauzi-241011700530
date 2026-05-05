import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const TristateExample(),
    );
  }
}

class TristateExample extends StatefulWidget {
  const TristateExample({super.key});

  @override
  State<TristateExample> createState() => _TristateExampleState();
}

class _TristateExampleState extends State<TristateExample> {
  // Data dummy untuk list item
  final List<Map<String, dynamic>> _items = [
    {'title': 'Kirim Notifikasi Push', 'isChecked': false},
    {'title': 'Email Marketing', 'isChecked': false},
    {'title': 'SMS Gateway', 'isChecked': false},
  ];

  // Logika untuk menentukan status Parent Checkbox
  bool? get _parentValue {
    final checkedCount = _items.where((i) => i['isChecked'] == true).length;
    if (checkedCount == 0) return false; // Unchecked
    if (checkedCount == _items.length) return true; // Checked
    return null; // Indeterminate (Tristate)
  }

  void _onParentClick(bool? value) {
    setState(() {
      // Jika diklik saat null atau false, jadikan semua true. Jika true, jadikan semua false.
      bool newValue = value ?? true;
      for (var item in _items) {
        item['isChecked'] = newValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tristate Checkbox Dart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // CARD UNTUK PARENT
            Card(
              elevation: 0,
              color: Colors.blue.withOpacity(0.1),
              child: ListTile(
                title: const Text(
                  'Pilih Semua Layanan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Checkbox(
                  tristate: true, // AKTIFKAN FITUR TRISTATE
                  value: _parentValue,
                  onChanged: _onParentClick,
                ),
              ),
            ),
            const Divider(),
            
            // LIST UNTUK CHILD
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]['title']),
                    leading: Checkbox(
                      value: _items[index]['isChecked'],
                      onChanged: (bool? value) {
                        setState(() {
                          _items[index]['isChecked'] = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}