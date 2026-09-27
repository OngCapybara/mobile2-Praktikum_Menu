import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../widgets/app_drawer.dart';
import '../widgets/menu_card.dart';
import 'detail_pages.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  // Daftar tampilan untuk tiap tab BottomNavigationBar (Poin 4)
  final List<Widget> _pages = const [
    _MenuGridBody(),          // Tab 0: Grid 8 Menu
    NotificationListPage(),  // Tab 1: List Notifikasi (Poin 3)
    ProfilPage(),            // Tab 2: Akun/Profil
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      // IndexedStack menjaga state antar tab saat berpindah tampilan (Poin 4)
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
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

// Private Widget khusus untuk merender Grid 8 Menu dengan crossAxisCount: 2
class _MenuGridBody extends StatelessWidget {
  const _MenuGridBody();

  // Minimal 8 Menu bertema Kampus (Poin 1)
  final List<MenuItem> _menuList = const [
    MenuItem(title: 'Profil Mahasiswa', icon: Icons.person, page: ProfilPage()),
    MenuItem(title: 'Jadwal Kuliah', icon: Icons.calendar_today, page: JadwalPage()),
    MenuItem(title: 'Nilai KHS', icon: Icons.grade, page: NilaiPage()),
    MenuItem(title: 'Pengumuman', icon: Icons.campaign, page: PengumumanPage()),
    MenuItem(title: 'Pembayaran UKT', icon: Icons.payment, page: PembayaranPage()),
    MenuItem(title: 'Perpustakaan', icon: Icons.menu_book, page: PerpustakaanPage()),
    MenuItem(title: 'Transkrip Nilai', icon: Icons.assignment, page: TranskripPage()),
    MenuItem(title: 'Pengaturan', icon: Icons.settings, page: PengaturanPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Mengubah grid menjadi 2 kolom (Poin 2)
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: _menuList.length,
      itemBuilder: (context, index) {
        return MenuCard(item: _menuList[index]);
      },
    );
  }
}