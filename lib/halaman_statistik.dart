import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'daftar_tugas.dart';

/// Halaman statistik. Semua angka dihitung dari state bersama, bukan
/// disimpan sendiri, jadi otomatis ikut berubah saat tugas ditambah,
/// diselesaikan, atau dihapus.
class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DaftarTugas>();
    final teks = Theme.of(context).textTheme;
    final persen = data.persentaseSelesai;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _KartuAngka(
            ikon: Icons.assignment_outlined,
            label: 'Total tugas',
            nilai: '${data.total}',
          ),
          _KartuAngka(
            ikon: Icons.check_circle_outline,
            label: 'Selesai',
            nilai: '${data.jumlahSelesai}',
          ),
          _KartuAngka(
            ikon: Icons.pending_actions_outlined,
            label: 'Belum selesai',
            nilai: '${data.jumlahAktif}',
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Persentase selesai', style: teks.titleMedium),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: persen / 100,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${persen.toStringAsFixed(0)}%',
                    style: teks.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KartuAngka extends StatelessWidget {
  const _KartuAngka({
    required this.ikon,
    required this.label,
    required this.nilai,
  });

  final IconData ikon;
  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        leading: Icon(ikon),
        title: Text(label),
        trailing: Text(nilai, style: teks.titleLarge),
      ),
    );
  }
}
