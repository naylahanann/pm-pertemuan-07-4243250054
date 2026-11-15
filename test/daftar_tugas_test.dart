import 'package:flutter_test/flutter_test.dart';
import 'package:planner_tugas/daftar_tugas.dart';

void main() {
  late DaftarTugas daftar;

  setUp(() {
    daftar = DaftarTugas();
  });

  test('tambah menambahkan tugas belum selesai dan memberi tahu listener', () {
    var dipanggil = 0;
    daftar.addListener(() => dipanggil++);

    daftar.tambah(
      judul: 'Laporan',
      mataKuliah: 'Basis Data',
      tenggat: DateTime(2026, 12, 1),
    );

    expect(daftar.total, 1);
    expect(daftar.tugas.first.judul, 'Laporan');
    expect(daftar.tugas.first.selesai, isFalse);
    expect(daftar.jumlahAktif, 1);
    expect(dipanggil, 1);
  });

  test('tandaiSelesai mengubah status dan statistik', () {
    daftar.tambah(
      judul: 'Tugas A',
      mataKuliah: 'Mobile',
      tenggat: DateTime(2026, 12, 1),
    );
    final id = daftar.tugas.first.id;

    daftar.tandaiSelesai(id, true);
    expect(daftar.jumlahSelesai, 1);
    expect(daftar.jumlahAktif, 0);

    daftar.tandaiSelesai(id, false);
    expect(daftar.jumlahSelesai, 0);
    expect(daftar.jumlahAktif, 1);
  });

  test('hapus membuang tugas dan mengabaikan id yang tidak ada', () {
    daftar.tambah(
      judul: 'Tugas A',
      mataKuliah: 'Mobile',
      tenggat: DateTime(2026, 12, 1),
    );
    daftar.tambah(
      judul: 'Tugas B',
      mataKuliah: 'Jaringan',
      tenggat: DateTime(2026, 12, 2),
    );
    final idPertama = daftar.tugas.first.id;

    daftar.hapus(idPertama);
    expect(daftar.total, 1);
    expect(daftar.tugas.first.judul, 'Tugas B');

    daftar.hapus(999);
    expect(daftar.total, 1);
  });

  test(
    'persentaseSelesai bernilai 0 saat kosong dan 50 saat satu dari dua',
    () {
      expect(daftar.persentaseSelesai, 0);

      daftar.tambah(
        judul: 'Tugas A',
        mataKuliah: 'Mobile',
        tenggat: DateTime(2026, 12, 1),
      );
      daftar.tambah(
        judul: 'Tugas B',
        mataKuliah: 'Jaringan',
        tenggat: DateTime(2026, 12, 2),
      );
      daftar.tandaiSelesai(daftar.tugas.first.id, true);

      expect(daftar.persentaseSelesai, 50);
    },
  );
}
