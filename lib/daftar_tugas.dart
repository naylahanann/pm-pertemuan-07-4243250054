import 'package:flutter/foundation.dart';

import 'tugas_kuliah.dart';

/// State bersama: dipakai halaman daftar, form, statistik, dan badge navigasi.
/// Setiap perubahan data memanggil notifyListeners() agar widget yang
/// mendengarkan dibangun ulang.
class DaftarTugas extends ChangeNotifier {
  DaftarTugas({List<TugasKuliah> awal = const []})
    : _tugas = List.of(awal),
      _idBerikutnya = awal.fold<int>(0, (m, t) => t.id > m ? t.id : m) + 1;

  final List<TugasKuliah> _tugas;
  int _idBerikutnya;

  /// Salinan yang tidak bisa diubah dari luar; perubahan hanya lewat method.
  List<TugasKuliah> get tugas => List.unmodifiable(_tugas);

  int get total => _tugas.length;
  int get jumlahSelesai => _tugas.where((t) => t.selesai).length;
  int get jumlahAktif => total - jumlahSelesai;

  /// Persentase 0 sampai 100; 0 bila belum ada tugas.
  double get persentaseSelesai => total == 0 ? 0 : jumlahSelesai / total * 100;

  void tambah({
    required String judul,
    required String mataKuliah,
    required DateTime tenggat,
  }) {
    _tugas.add(
      TugasKuliah(
        id: _idBerikutnya++,
        judul: judul,
        mataKuliah: mataKuliah,
        tenggat: tenggat,
      ),
    );
    notifyListeners();
  }

  void tandaiSelesai(int id, bool selesai) {
    final indeks = _tugas.indexWhere((t) => t.id == id);
    if (indeks == -1) return;
    _tugas[indeks] = _tugas[indeks].copyWith(selesai: selesai);
    notifyListeners();
  }

  void hapus(int id) {
    final jumlahAwal = _tugas.length;
    _tugas.removeWhere((t) => t.id == id);
    if (_tugas.length != jumlahAwal) notifyListeners();
  }
}
