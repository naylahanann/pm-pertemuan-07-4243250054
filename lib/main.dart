// Tugas Rutin 7: Planner Tugas Kuliah
// Nama: Nayla Luthfiah Hanan  NIM: 4243250054
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'daftar_tugas.dart';
import 'router.dart';
import 'tugas_kuliah.dart';

void main() {
  runApp(const PlannerApp());
}

/// Data contoh agar halaman tidak kosong saat pertama dibuka.
List<TugasKuliah> _dataAwal() {
  final sekarang = DateTime.now();
  return [
    TugasKuliah(
      id: 1,
      judul: 'Tugas Rutin 7',
      mataKuliah: 'Pemrograman Mobile',
      tenggat: sekarang.add(const Duration(days: 5)),
    ),
    TugasKuliah(
      id: 2,
      judul: 'Laporan Praktikum',
      mataKuliah: 'Basis Data',
      tenggat: sekarang.add(const Duration(days: 2)),
    ),
    TugasKuliah(
      id: 3,
      judul: 'Rangkuman Bab 3',
      mataKuliah: 'Kecerdasan Buatan',
      tenggat: sekarang.add(const Duration(days: 9)),
      selesai: true,
    ),
  ];
}

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key});

  static const _seed = Colors.indigo;

  @override
  Widget build(BuildContext context) {
    // Provider diletakkan di atas MaterialApp supaya semua halaman
    // (termasuk halaman form yang dibuka dengan push) bisa mengaksesnya.
    return ChangeNotifierProvider(
      create: (_) => DaftarTugas(awal: _dataAwal()),
      child: MaterialApp.router(
        title: 'Planner Tugas Kuliah',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: _seed)),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: _seed,
            brightness: Brightness.dark,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
