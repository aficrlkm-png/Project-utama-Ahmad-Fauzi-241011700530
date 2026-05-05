import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  _CompleteRadioButtonFormState createState() => _CompleteRadioButtonFormState();
}

class _CompleteRadioButtonFormState extends State<RadiobuttonPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();

  String? _selectedGender;
  String? _selectedJob;
  String? _selectedWorkType;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _jobOptions = [
    {'value': 'Admin', 'icon': Icons.support_agent, 'color': const Color(0xFF2196F3), 'description': 'Mengelola Data'},
    {'value': 'Guru', 'icon': Icons.school, 'color': const Color(0xFFF9C27B), 'description': 'Mendidik generasi'},
    {'value': 'Programmer', 'icon': Icons.code, 'color': const Color(0xFF4CAF50), 'description': 'Mengembangkan software'},
    {'value': 'Pengusaha', 'icon': Icons.business, 'color': const Color(0xFFF44336), 'description': 'Mengelola bisnis'},
    {'value': 'Desainer', 'icon': Icons.design_services, 'color': const Color(0xFF00BCD4), 'description': 'Kreativitas visual'},
  ];

  final List<Map<String, dynamic>> _workTypeOptions = [
    {'value': 'Full Time', 'subtitle': 'Bekerja 40 jam/minggu', 'icon': Icons.work, 'color': const Color(0xFF00897B), 'benefits': ['Asuransi kesehatan', 'Tunjangan hari raya']},
    {'value': 'Part Time', 'subtitle': 'Bekerja < 40 jam/minggu', 'icon': Icons.access_time, 'color': const Color(0xFF0288D1), 'benefits': ['Jadwal fleksibel', 'Liburan panjang']},
    {'value': 'Freelance', 'subtitle': 'Pekerja lepas', 'icon': Icons.laptop, 'color': const Color(0xFF7B1FA2), 'benefits': ['Kerja remote', 'Rate per project']},
    {'value': 'Kontrak', 'subtitle': 'Perjanjian waktu tertentu', 'icon': Icons.description, 'color': const Color(0xFFE65100), 'benefits': ['Bonus kontrak', 'Evaluasi berkala']},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _namaController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  // --- LOGIKA FORM ---

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text('Pendaftaran Berhasil'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultRow('Nama', _namaController.text),
              _buildResultRow('Umur', '${_umurController.text} tahun'),
              _buildResultRow('Gender', _selectedGender!),
              _buildResultRow('Pekerjaan', _selectedJob!),
              _buildResultRow('Tipe', _selectedWorkType!),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // --- BUILD UI UTAMA ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Form dengan RadioButton',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF00695C),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00695C), Color(0xFF00897B)],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildModernSection('Data Diri', Icons.person_outline, [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildModernTextField(
                            controller: _namaController,
                            label: 'Nama Lengkap',
                            hint: 'Masukkan nama lengkap Anda',
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Nama tidak boleh kosong';
                              if (value.length < 3) return 'Nama minimal 3 karakter';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildModernTextField(
                            controller: _umurController,
                            label: 'Umur',
                            hint: 'Masukkan umur Anda',
                            icon: Icons.cake_outlined,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Umur tidak boleh kosong';
                              int? age = int.tryParse(value);
                              if (age == null || age < 17 || age > 100) return 'Umur harus antara 17-100 tahun';
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                _buildModernSection('Jenis Kelamin', Icons.people_outline, [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FormField<String>(
                        validator: (value) => value == null || value.isEmpty ? 'Jenis kelamin harus dipilih' : null,
                        builder: (FormFieldState<String> state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildAnimatedGenderCard(
                                      title: 'Laki-laki',
                                      value: 'Laki-laki',
                                      groupValue: _selectedGender,
                                      icon: Icons.male,
                                      color: const Color(0xFF2196F3),
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                                      ),
                                      onChanged: (value) {
                                        setState(() => _selectedGender = value);
                                        state.didChange(value);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildAnimatedGenderCard(
                                      title: 'Perempuan',
                                      value: 'Perempuan',
                                      groupValue: _selectedGender,
                                      icon: Icons.female,
                                      color: const Color(0xFFE91E63),
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFFE91E63), Color(0xFFF06292)],
                                      ),
                                      onChanged: (value) {
                                        setState(() => _selectedGender = value);
                                        state.didChange(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8, top: 12),
                                  child: _buildErrorText(state.errorText!),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                _buildModernSection('Pekerjaan', Icons.work_outline, [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: FormField<String>(
                        validator: (value) => value == null || value.isEmpty ? 'Pekerjaan harus dipilih' : null,
                        builder: (FormFieldState<String> state) {
                          return Column(
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: _jobOptions.asMap().entries.map((entry) {
                                  return _buildAnimatedChoiceChip(
                                    job: entry.value,
                                    isSelected: _selectedJob == entry.value['value'],
                                    index: entry.key,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedJob = selected ? entry.value['value'] : null;
                                        state.didChange(_selectedJob);
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: _buildErrorText(state.errorText!),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                _buildModernSection('Tipe Pekerjaan', Icons.business_center_outlined, [
                  FormField<String>(
                    validator: (value) => value == null || value.isEmpty ? 'Tipe pekerjaan harus dipilih' : null,
                    builder: (FormFieldState<String> state) {
                      return Column(
                        children: [
                          ..._workTypeOptions.map((work) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildModernWorkTile(
                                  work: work,
                                  groupValue: _selectedWorkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedWorkType = value;
                                      state.didChange(value);
                                    });
                                  },
                                ),
                              )),
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: _buildErrorText(state.errorText!),
                            ),
                        ],
                      );
                    },
                  ),
                ]),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _buildGradientButton(
                        onPressed: _submitForm,
                        text: 'Simpan Data',
                        icon: Icons.save,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- HELPER UI WIDGETS ---

  Widget _buildModernSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF00695C), size: 22),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF00695C)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF00695C), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildAnimatedGenderCard({
    required String title,
    required String value,
    required String? groupValue,
    required IconData icon,
    required Color color,
    required Gradient gradient,
    required Function(String) onChanged,
  }) {
    bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? color : Colors.grey.shade200, width: 2),
          boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))] : [],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: isSelected ? color : Colors.grey),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? color : Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedChoiceChip({
    required Map<String, dynamic> job,
    required bool isSelected,
    required int index,
    required Function(bool) onSelected,
  }) {
    return ChoiceChip(
      avatar: Icon(job['icon'], size: 18, color: isSelected ? Colors.white : job['color']),
      label: Text(job['value']),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: job['color'],
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isSelected ? job['color'] : Colors.grey.shade300),
      ),
    );
  }

  Widget _buildModernWorkTile({
    required Map<String, dynamic> work,
    required String? groupValue,
    required Function(String) onChanged,
  }) {
    bool isSelected = work['value'] == groupValue;
    return InkWell(
      onTap: () => onChanged(work['value']),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? work['color'].withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? work['color'] : Colors.grey.shade200, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? work['color'] : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(work['icon'], color: isSelected ? Colors.white : Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(work['value'], style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? work['color'] : Colors.black87)),
                      Text(work['subtitle'], style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                Radio<String>(
                  value: work['value'],
                  groupValue: groupValue,
                  onChanged: (v) => onChanged(v!),
                  activeColor: work['color'],
                ),
              ],
            ),
            if (isSelected && work['benefits'] != null) ...[
              const Divider(height: 24),
              Wrap(
                spacing: 8,
                children: (work['benefits'] as List<String>).map((benefit) => 
                  Chip(
                    label: Text(benefit, style: const TextStyle(fontSize: 10)),
                    backgroundColor: work['color'].withOpacity(0.1),
                    side: BorderSide.none,
                    visualDensity: VisualDensity.compact,
                  )
                ).toList(),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton({required VoidCallback onPressed, required String text, required IconData icon}) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF00695C), Color(0xFF00897B)]),
        boxShadow: [BoxShadow(color: const Color(0xFF00695C).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildErrorText(String text) {
    return Text(text, style: const TextStyle(color: Colors.red, fontSize: 12));
  }
}