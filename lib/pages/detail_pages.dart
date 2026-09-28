import 'package:flutter/material.dart';
import '../main.dart'; // Import main.dart agar MyApp bisa diakses
import 'simple_page.dart';

class NotificationListPage extends StatelessWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: const [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigo,
            child: Icon(Icons.payment, color: Colors.white),
          ),
          title: Text('Pembayaran UKT Berhasil'),
          subtitle: Text('Pembayaran UKT Semester Genap telah terverifikasi.'),
          trailing: Text('10:00'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.campaign, color: Colors.white),
          ),
          title: Text('Jadwal Ujian Akhir Semester'),
          subtitle: Text('Jadwal UAS dapat diakses pada menu Jadwal Kuliah.'),
          trailing: Text('Kemarin'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.grade, color: Colors.white),
          ),
          title: Text('Nilai Matakuliah Keluar'),
          subtitle: Text('Nilai Pemrograman Mobile telah diinput oleh Dosen.'),
          trailing: Text('2 Hari lalu'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.warning, color: Colors.white),
          ),
          title: Text('Peringatan Pengisian KRS'),
          subtitle: Text('Batas akhir pengisian KRS adalah tanggal 30 ini.'),
          trailing: Text('3 Hari lalu'),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.menu_book, color: Colors.white),
          ),
          title: Text('Pengembalian Buku Perpustakaan'),
          subtitle: Text('Masa pinjam buku "Flutter Mobile" tersisa 1 hari.'),
          trailing: Text('5 Hari lalu'),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Halaman Pengaturan (Dark Mode Toggle)
// -----------------------------------------------------------------------------
class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MyApp.of(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              secondary: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: Colors.indigo,
              ),
              title: const Text('Mode Gelap (Dark Mode)'),
              subtitle: Text(
                isDark ? 'Tema gelap aktif' : 'Tema terang aktif',
              ),
              value: isDark,
              onChanged: (value) {
                MyApp.of(context).toggleTheme(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Halaman Detail Lainnya
// -----------------------------------------------------------------------------
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Profil Mahasiswa', icon: Icons.person);
}

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Jadwal Kuliah', icon: Icons.calendar_today);
}

class NilaiPage extends StatelessWidget {
  const NilaiPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Nilai KHS', icon: Icons.grade);
}

class PengumumanPage extends StatelessWidget {
  const PengumumanPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Pengumuman', icon: Icons.campaign);
}

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Pembayaran UKT', icon: Icons.payment);
}

class PerpustakaanPage extends StatelessWidget {
  const PerpustakaanPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Perpustakaan', icon: Icons.menu_book);
}

class TranskripPage extends StatelessWidget {
  const TranskripPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Transkrip Nilai', icon: Icons.assignment);
}