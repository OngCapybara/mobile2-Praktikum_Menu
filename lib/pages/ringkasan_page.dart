import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';

class RingkasanPage extends StatelessWidget {
  final Mahasiswa data;

  const RingkasanPage({super.key, required this.data});

  Widget _baris(String label, String nilai) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(nilai, style: const TextStyle(fontSize: 16, color: Colors.black87)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Data'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(Icons.check_circle, size: 64, color: Colors.green),
          const SizedBox(height: 8),
          const Text(
            'Registrasi Berhasil',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                _baris('Nama Lengkap', data.nama),
                const Divider(height: 1),
                _baris('NPM', data.npm),
                const Divider(height: 1),
                _baris('Nomor HP', data.noHp),
                const Divider(height: 1),
                _baris('Email', data.email),
                const Divider(height: 1),
                _baris('Jenis Kelamin', data.jenisKelamin),
                const Divider(height: 1),
                _baris('Program Studi', data.prodi),
                const Divider(height: 1),
                // Display umur dihitung otomatis (Tugas 4)
                _baris('Tanggal Lahir & Umur', '${formatTanggal(data.tanggalLahir)} (${data.umur} Tahun)'),
                const Divider(height: 1),
                _baris('Minat', data.minat.isEmpty ? '-' : data.minat.join(', ')),
                const Divider(height: 1),
                _baris('Notifikasi Email', data.notifikasi ? 'Ya' : 'Tidak'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              // Kembali ke halaman awal/menu utama
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Kembali ke Menu Utama'),
          ),
        ],
      ),
    );
  }
}