import 'package:flutter/material.dart';
import 'package:p6checkbox/pertemuan/pertemuan_page.dart';

class ListViewPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ListViewPage({super.key, required this.userData, required Map<dynamic, dynamic> pertemuan_page});

  @override
  State<ListViewPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListViewPage> {
  // Data list tetap sama sesuai keinginan Anda
  final List<Pertemuan> daftarPertemuan = [
    Pertemuan(title: 'Pertemuan 1', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 2', subtitle: 'Widget & Button'),
    Pertemuan(title: 'Pertemuan 3', subtitle: 'Activity & Intent'),
    Pertemuan(title: 'Pertemuan 4', subtitle: 'Toast & AlertDialog'),
    Pertemuan(title: 'Pertemuan 5', subtitle: 'List View'),
    Pertemuan(title: 'Pertemuan 6', subtitle: 'CheckBox'),
    Pertemuan(title: 'Pertemuan 7', subtitle: 'Radio Button'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pertemuan 5", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: daftarPertemuan.length,
        itemBuilder: (context, index) {
          // Perbaikan penamaan variabel agar tidak bentrok dengan nama Class
          final item = daftarPertemuan[index]; 
          
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.list, color: Colors.blueAccent),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PertemuanPage(pertemuan: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Class Model Data
class Pertemuan {
  final String title;
  final String subtitle;

  Pertemuan({required this.title, required this.subtitle});
}