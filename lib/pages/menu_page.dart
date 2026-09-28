import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../models/menu_item.dart';
import '../widgets/app_drawer.dart';
import '../widgets/menu_card.dart';
import 'daftar_pendaftar_page.dart';
import 'detail_pages.dart';
import 'registrasi_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  // List penyimpan state pendaftar (Tantangan Tugas 6)
  final List<Mahasiswa> _listMahasiswa = [];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _MenuGridBody(listMahasiswa: _listMahasiswa),
      const NotificationListPage(),
      const ProfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Menu Utama Kampus'
              : _selectedIndex == 1
                  ? 'Pemberitahuan'
                  : 'Akun Saya',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (idx) => setState(() => _selectedIndex = idx),
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifikasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}

class _MenuGridBody extends StatelessWidget {
  final List<Mahasiswa> listMahasiswa;

  const _MenuGridBody({required this.listMahasiswa});

  @override
  Widget build(BuildContext context) {
    // 8+ Menu Grid (Tugas 5: Menu Registrasi dibuka via Navigator.push)
    final List<MenuItem> menuList = [
      MenuItem(
        title: 'Form Registrasi',
        icon: Icons.how_to_reg,
        page: RegistrasiPage(daftarMahasiswa: listMahasiswa),
      ),
      MenuItem(
        title: 'Daftar Pendaftar',
        icon: Icons.people_alt,
        page: DaftarPendaftarPage(daftarMahasiswa: listMahasiswa),
      ),
      const MenuItem(title: 'Profil Mahasiswa', icon: Icons.person, page: ProfilPage()),
      const MenuItem(title: 'Jadwal Kuliah', icon: Icons.calendar_today, page: JadwalPage()),
      const MenuItem(title: 'Nilai KHS', icon: Icons.grade, page: NilaiPage()),
      const MenuItem(title: 'Pengumuman', icon: Icons.campaign, page: PengumumanPage()),
      const MenuItem(title: 'Pembayaran UKT', icon: Icons.payment, page: PembayaranPage()),
      const MenuItem(title: 'Perpustakaan', icon: Icons.menu_book, page: PerpustakaanPage()),
      const MenuItem(title: 'Pengaturan', icon: Icons.settings, page: PengaturanPage()),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: menuList.length,
      itemBuilder: (context, index) {
        return MenuCard(item: menuList[index]);
      },
    );
  }
}