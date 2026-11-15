import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'daftar_tugas.dart';
import 'tugas_kuliah.dart';

enum FilterTugas {
  semua('Semua'),
  aktif('Aktif'),
  selesai('Selesai');

  const FilterTugas(this.label);
  final String label;
}

/// Halaman daftar. Stateful karena menyimpan filter yang dipilih.
/// Filter adalah ephemeral state: hanya dipakai di halaman ini, jadi
/// dikelola dengan setState, bukan Provider.
class HalamanDaftar extends StatefulWidget {
  const HalamanDaftar({super.key});

  @override
  State<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends State<HalamanDaftar> {
  FilterTugas _filter = FilterTugas.semua;

  List<TugasKuliah> _saring(List<TugasKuliah> semua) => switch (_filter) {
    FilterTugas.semua => semua,
    FilterTugas.aktif => semua.where((t) => !t.selesai).toList(),
    FilterTugas.selesai => semua.where((t) => t.selesai).toList(),
  };

  @override
  Widget build(BuildContext context) {
    // watch: halaman dibangun ulang setiap kali state bersama berubah.
    final tampil = _saring(context.watch<DaftarTugas>().tugas);

    return Scaffold(
      appBar: AppBar(title: const Text('Planner Tugas Kuliah')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/tambah'),
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                for (final f in FilterTugas.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(f.label),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: tampil.isEmpty
                ? const Center(child: Text('Tidak ada tugas'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                    itemCount: tampil.length,
                    itemBuilder: (context, i) => KartuTugas(tugas: tampil[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Satu baris tugas: centang selesai, judul, keterangan, dan tombol hapus.
class KartuTugas extends StatelessWidget {
  const KartuTugas({super.key, required this.tugas});

  final TugasKuliah tugas;

  @override
  Widget build(BuildContext context) {
    final daftar = context.read<DaftarTugas>();
    final gaya = Theme.of(context).textTheme.titleMedium;

    return Card(
      child: ListTile(
        leading: Checkbox(
          value: tugas.selesai,
          onChanged: (nilai) => daftar.tandaiSelesai(tugas.id, nilai ?? false),
        ),
        title: Text(
          tugas.judul,
          style: tugas.selesai
              ? gaya?.copyWith(decoration: TextDecoration.lineThrough)
              : gaya,
        ),
        subtitle: Text(
          '${tugas.mataKuliah} • Tenggat ${formatTanggal(tugas.tenggat)}',
        ),
        trailing: IconButton(
          tooltip: 'Hapus',
          icon: const Icon(Icons.delete_outline),
          onPressed: () => daftar.hapus(tugas.id),
        ),
      ),
    );
  }
}
