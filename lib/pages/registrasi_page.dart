import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/mahasiswa.dart';
import 'ringkasan_page.dart';

class RegistrasiPage extends StatefulWidget {
  final List<Mahasiswa> daftarMahasiswa;

  const RegistrasiPage({super.key, required this.daftarMahasiswa});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _npmCtrl = TextEditingController();
  final _noHpCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  String _jenisKelamin = 'Laki-laki';
  String? _prodi;
  DateTime? _tanggalLahir;
  final Set<String> _minat = {};
  bool _notifikasi = true;
  bool _sembunyikanPassword = true;

  final List<String> _daftarProdi = const [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Rekayasa Perangkat Lunak',
  ];

  final List<String> _daftarMinat = const [
    'Mobile Programming',
    'Web Development',
    'Data Science',
  ];

  @override
  void dispose() {
    _namaCtrl.dispose();
    _npmCtrl.dispose();
    _noHpCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dekor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime(2005, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _tanggalLahir = picked);
    }
  }

  void _submit() {
    // 1. Validasi TextFormField
    if (!_formKey.currentState!.validate()) return;

    // 2. Validasi Tanggal Lahir
    if (_tanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal lahir belum dipilih')),
      );
      return;
    }

    // 3. Validasi Minat (Tugas 3: Minimal 1 minat tercentang)
    if (_minat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih minimal 1 minat/keahlian!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text('Kirim data registrasi atas nama ${_namaCtrl.text}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              _kirimData();
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void _kirimData() {
    final data = Mahasiswa(
      nama: _namaCtrl.text.trim(),
      npm: _npmCtrl.text,
      noHp: _noHpCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      jenisKelamin: _jenisKelamin,
      prodi: _prodi!,
      tanggalLahir: _tanggalLahir!,
      minat: _minat.toList(),
      notifikasi: _notifikasi,
    );

    // Simpan ke List global (Tantangan Tugas 6)
    widget.daftarMahasiswa.add(data);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi berhasil disimpan')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RingkasanPage(data: data)),
    );
  }

  void _reset() {
    _formKey.currentState!.reset();
    setState(() {
      _jenisKelamin = 'Laki-laki';
      _prodi = null;
      _tanggalLahir = null;
      _minat.clear();
      _notifikasi = true;
      _sembunyikanPassword = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Mahasiswa'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaCtrl,
              textInputAction: TextInputAction.next,
              decoration: _dekor('Nama Lengkap', Icons.person),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
                if (v.trim().length < 3) return 'Nama minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _npmCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: _dekor('NPM', Icons.badge),
              validator: (v) {
                if (v == null || v.isEmpty) return 'NPM wajib diisi';
                if (v.length < 8) return 'NPM minimal 8 digit';
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Field Nomor HP (Tugas 1: angka, diawali 08, 10-13 digit)
            TextFormField(
              controller: _noHpCtrl,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: _dekor('Nomor HP', Icons.phone),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Nomor HP wajib diisi';
                final regexHp = RegExp(r'^08[0-9]{8,11}$');
                if (!regexHp.hasMatch(v.trim())) {
                  return 'Harus angka, diawali 08, dan panjang 10-13 digit';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: _dekor('Email', Icons.email),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                final pola = RegExp(r'^[\w\.-]+@[\w-]+\.[\w-.]+$');
                if (!pola.hasMatch(v.trim())) return 'Format email tidak valid';
                return null;
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _passwordCtrl,
              obscureText: _sembunyikanPassword,
              decoration: _dekor('Password', Icons.lock).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _sembunyikanPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () => setState(
                      () => _sembunyikanPassword = !_sembunyikanPassword),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password wajib diisi';
                if (v.length < 6) return 'Password minimal 6 karakter';
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Field Konfirmasi Password (Tugas 2)
            TextFormField(
              controller: _confirmPasswordCtrl,
              obscureText: _sembunyikanPassword,
              decoration: _dekor('Konfirmasi Password', Icons.lock_clock),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Konfirmasi password wajib diisi';
                if (v != _passwordCtrl.text) {
                  return 'Konfirmasi password tidak cocok dengan password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            Text('Jenis Kelamin', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'Laki-laki',
                  label: Text('Laki-laki'),
                  icon: Icon(Icons.male),
                ),
                ButtonSegment(
                  value: 'Perempuan',
                  label: Text('Perempuan'),
                  icon: Icon(Icons.female),
                ),
              ],
              selected: {_jenisKelamin},
              onSelectionChanged: (s) =>
                  setState(() => _jenisKelamin = s.first),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _prodi,
              decoration: _dekor('Program Studi', Icons.school),
              items: _daftarProdi
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) => setState(() => _prodi = v),
              validator: (v) => v == null ? 'Pilih program studi' : null,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pilihTanggal,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                alignment: Alignment.centerLeft,
              ),
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _tanggalLahir == null
                    ? 'Pilih tanggal lahir'
                    : 'Tanggal lahir: ${formatTanggal(_tanggalLahir!)}',
              ),
            ),
            const SizedBox(height: 16),

            Text('Minat (Pilih minimal 1)', style: Theme.of(context).textTheme.labelLarge),
            ..._daftarMinat.map(
              (m) => CheckboxListTile(
                title: Text(m),
                value: _minat.contains(m),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (dicentang) {
                  setState(() {
                    if (dicentang == true) {
                      _minat.add(m);
                    } else {
                      _minat.remove(m);
                    }
                  });
                },
              ),
            ),
            SwitchListTile(
              title: const Text('Terima notifikasi email'),
              contentPadding: EdgeInsets.zero,
              value: _notifikasi,
              onChanged: (v) => setState(() => _notifikasi = v),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.send),
                    label: const Text('Daftar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}