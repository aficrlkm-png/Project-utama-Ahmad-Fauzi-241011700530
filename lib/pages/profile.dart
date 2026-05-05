import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 1. Header
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3),
              ),
              Positioned(
                bottom: 30,
                child: Column(
                  children: [
                    const Text(
                      'Ahmad Fauzi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Jakarta, Indonesia',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/zie.png'),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 2. Statistik
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('248', 'Posts'),
                _buildStatItem('12.5K', 'Followers'),
                _buildStatItem('894', 'Following'),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 3. About Me
          _buildSectionTitle('About Me'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Mahasiswa Sistem Informasi semester 4 yang fokus pada pengembangan Flutter dan SPK. Serta memiliki minat besar dalam UI/UX design dan mobile development. Aktif mengikuti berbagai proyek dan komunitas teknologi untuk terus meningkatkan skill dan pengetahuan di bidang IT. Selain itu, saya juga memiliki pengalaman dalam menggunakan Laravel untuk pengembangan web dan Figma untuk desain UI/UX.',
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ),

          const SizedBox(height: 25),

          // 4. Information
          _buildSectionTitle('Information'),
          _buildInfoTile(Icons.email_outlined, 'ahmad.fauzi@example.com'),
          _buildInfoTile(Icons.phone_android_outlined, '+62 123-456-7890'),
          _buildInfoTile(Icons.work_outline, 'Mobile Programmer'),

          const SizedBox(height: 25),

          // 5. SKILLS & INTERESTS (Sudah Ditambahkan Kembali)
          _buildSectionTitle('Skills & Interests'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildSkillChip('Flutter', Colors.blue),
                _buildSkillChip('UI/UX', Colors.purple),
                _buildSkillChip('Laravel', Colors.red),
                _buildSkillChip('Figma', Colors.pink),
                _buildSkillChip('SQL', Colors.green),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 6. Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Share'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(text, style: const TextStyle(fontSize: 14)),
      dense: true,
    );
  }

  Widget _buildSkillChip(String label, Color color) {
    return Chip(
      label: Text(label, style: TextStyle(color: color, fontSize: 12)),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.2)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}