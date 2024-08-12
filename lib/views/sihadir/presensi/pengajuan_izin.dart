import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class PengajuanIzin extends StatefulWidget {
  const PengajuanIzin({Key? key}) : super(key: key);

  @override
  _PengajuanIzinState createState() => _PengajuanIzinState();
}

class _PengajuanIzinState extends State<PengajuanIzin> {
  FilePickerResult? result;
  String? filePath;
  bool _isChecked = false;
  int _selectedNavbar = 1; // Added missing variable
  String _selectedStatus = 'Pilih'; // Added for dropdown

  Future<void> _pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'pdf'],
    );
    setState(() {
      if (result != null) {
        filePath = result!.files.single.path;
      }
    });
  }

  void changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  String deadlineIzin() {
  final now = DateTime.now();
  final currentDay = now.weekday;
    if (currentDay == DateTime.sunday) {
    return 'Hari ini libur';
  }
  final daysUntilSaturday = (DateTime.saturday - currentDay + 7) % 7;
  final deadline = daysUntilSaturday == 0 ? 0 : daysUntilSaturday;
  return 'Waktu yang tersisa untuk mengunggah: $deadline Hari';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Si Hadir'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1548AD), Color(0xFF39EADD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                'Pengajuan Perizinan',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              _buildSectionContainer([
                _buildTextField('NIM'),
                _buildTextField('Nama Mahasiswa'),
                _buildTextField('Mata Kuliah'),
                _buildTextField('Keterangan'),
              ]),
              const SizedBox(height: 16.0),
              _buildSectionContainer([
                const Text(
                    'Ukuran file maksimum: 3MB,\nJumlah maksimum file: 1',
                    style: TextStyle(color: Colors.black)),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _pickFile,
                  child: Text(filePath != null
                      ? filePath!.split('/').last
                      : 'Unggah file'),
                ),
                const SizedBox(height: 8.0),
                const Text('Jenis file yang diizinkan:\njpg, jpeg, pdf',
                    style: TextStyle(color: Colors.black)),
                const SizedBox(height: 8.0),
                Text(deadlineIzin(),
                    style: TextStyle(color: Colors.red)),
              ]),
              const SizedBox(height: 16.0),
              _buildSectionContainer([
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Ubah status kehadiran',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.black),
                  items: ['Pilih', 'Hadir', 'Tidak Hadir'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                    });
                  },
                ),
              ]),
              const SizedBox(height: 16.0),
              _buildSectionContainer([
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(color: Colors.black),
                  maxLines: 4,
                ),
              ]),
              const SizedBox(height: 16.0),
              CheckboxListTile(
                title: const Text(
                    'Saya Menyatakan bahwa surat ini dibuat dengan sebenar-benarnya...',
                    style: TextStyle(color: Colors.white)),
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/attendance-update');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 16.0),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
