class Mahasiswa {
  final String nama;
  final String npm;
  final String noHp;
  final String email;
  final String jenisKelamin;
  final String prodi;
  final DateTime tanggalLahir;
  final List<String> minat;
  final bool notifikasi;

  Mahasiswa({
    required this.nama,
    required this.npm,
    required this.noHp,
    required this.email,
    required this.jenisKelamin,
    required this.prodi,
    required this.tanggalLahir,
    required this.minat,
    required this.notifikasi,
  });

  // Getter menghitung umur otomatis dari tanggal lahir
  int get umur {
    final now = DateTime.now();
    int age = now.year - tanggalLahir.year;
    if (now.month < tanggalLahir.month ||
        (now.month == tanggalLahir.month && now.day < tanggalLahir.day)) {
      age--;
    }
    return age;
  }
}

String formatTanggal(DateTime d) {
  final hari = d.day.toString().padLeft(2, '0');
  final bulan = d.month.toString().padLeft(2, '0');
  return '$hari-$bulan-${d.year}';
}