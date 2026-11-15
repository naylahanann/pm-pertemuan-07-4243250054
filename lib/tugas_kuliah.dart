/// Data satu tugas kuliah. Immutable: untuk mengubah status dipakai copyWith,
/// sehingga perubahan selalu lewat state bersama (DaftarTugas).
class TugasKuliah {
  const TugasKuliah({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    this.selesai = false,
  });

  final int id;
  final String judul;
  final String mataKuliah;
  final DateTime tenggat;
  final bool selesai;

  TugasKuliah copyWith({bool? selesai}) {
    return TugasKuliah(
      id: id,
      judul: judul,
      mataKuliah: mataKuliah,
      tenggat: tenggat,
      selesai: selesai ?? this.selesai,
    );
  }
}

/// Mengubah DateTime menjadi teks seperti '5/12/2026'.
String formatTanggal(DateTime t) => '${t.day}/${t.month}/${t.year}';
