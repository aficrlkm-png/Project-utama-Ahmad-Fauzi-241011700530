import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  // Controller untuk mengambil input teks
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();

  // State untuk Checkbox Hobi
  Map<String, bool> hobbies = {
    'Membaca': false,
    'Olahraga': false,
    'Musik': false,
    'Game': false,
    'Traveling': false,
  };

  bool _setujuSyarat = false;

  void _tampilkanDialogSukses() {
    // Mencari hobi yang dipilih
    List<String> hobiTerpilih = [];
    hobbies.forEach((key, value) {
      if (value) hobiTerpilih.add(key);
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 30,
              child: Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 15),
            const Text(
              'Pendaftaran Berhasil!',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Divider(),
            _buildInfoRow(Icons.person, 'Nama', _namaController.text),
            _buildInfoRow(Icons.tag, 'NIM', _nimController.text),
            _buildInfoRow(Icons.class_outlined, 'Kelas', _kelasController.text),
            _buildInfoRow(Icons.favorite, 'Hobi', hobiTerpilih.join(', ')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent[400],
        title: const Text('Form dengan Checkbox', style: TextStyle(color: Colors.black87)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card Data Diri
            _buildSectionCard(
              title: 'Data Diri',
              color: Colors.blue,
              child: Column(
                children: [
                  _buildTextField(_namaController, 'Nama Lengkap', Icons.person_outline),
                  const SizedBox(height: 10),
                  _buildTextField(_nimController, 'NIM', Icons.tag),
                  const SizedBox(height: 10),
                  _buildTextField(_kelasController, 'Kelas', Icons.class_outlined),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Card Hobi
            _buildSectionCard(
              title: 'Hobi',
              subtitle: '(Pilih minimal 1)',
              color: Colors.orange,
              child: Wrap(
                children: hobbies.keys.map((String key) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CheckboxListTile(
                      title: Text(key, style: const TextStyle(fontSize: 14)),
                      value: hobbies[key],
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          hobbies[key] = value!;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Syarat & Ketentuan
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: CheckboxListTile(
                title: const Text('Saya menyetujui syarat dan ketentuan yang berlaku', 
                  style: TextStyle(fontSize: 13)),
                value: _setujuSyarat,
                onChanged: (value) => setState(() => _setujuSyarat = value!),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Daftar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _setujuSyarat ? _tampilkanDialogSukses : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('DAFTAR SEKARANG', 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper UI Components
  Widget _buildSectionCard({required String title, String? subtitle, required Widget child, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 20, color: color),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              if (subtitle != null) ...[
                const SizedBox(width: 5),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ]
            ],
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}