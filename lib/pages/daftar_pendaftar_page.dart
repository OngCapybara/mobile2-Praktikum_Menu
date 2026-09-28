import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import 'ringkasan_page.dart';

class DaftarPendaftarPage extends StatelessWidget {
  final List<Mahasiswa> daftarMahasiswa;

  const DaftarPendaftarPage({super.key, required this.daftarMahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pendaftar'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: daftarMahasiswa.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data mahasiswa yang mendaftar.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: daftarMahasiswa.length,
              itemBuilder: (context, index) {
                final mhs = daftarMahasiswa[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(
                      mhs.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${mhs.prodi} • ${mhs.umur} Tahun\nHP: ${mhs.noHp}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RingkasanPage(data: mhs),
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