import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'daftar_tugas.dart';
import 'tugas_kuliah.dart';

/// Halaman form tambah tugas. Controller, tenggat, dan pesan galat adalah
/// state lokal halaman ini, jadi dikelola di State dengan setState.
class HalamanForm extends StatefulWidget {
  const HalamanForm({super.key});

  @override
  State<HalamanForm> createState() => _HalamanFormState();
}

class _HalamanFormState extends State<HalamanForm> {
  late final TextEditingController _judul;
  late final TextEditingController _mataKuliah;
  DateTime _tenggat = DateTime.now().add(const Duration(days: 7));
  String? _galat;

  @override
  void initState() {
    super.initState();
    // Dibuat sekali saat State dibuat.
    _judul = TextEditingController();
    _mataKuliah = TextEditingController();
  }

  @override
  void dispose() {
    // Wajib dibuang agar tidak terjadi kebocoran memori.
    _judul.dispose();
    _mataKuliah.dispose();
    super.dispose();
  }

  Future<void> _pilihTenggat() async {
    final sekarang = DateTime.now();
    final pilihan = await showDatePicker(
      context: context,
      initialDate: _tenggat,
      firstDate: sekarang.subtract(const Duration(days: 365)),
      lastDate: sekarang.add(const Duration(days: 365 * 3)),
    );
    if (!mounted || pilihan == null) return;
    setState(() => _tenggat = pilihan);
  }

  void _simpan() {
    final judul = _judul.text.trim();
    final mataKuliah = _mataKuliah.text.trim();

    if (judul.isEmpty || mataKuliah.isEmpty) {
      setState(() => _galat = 'Judul dan mata kuliah wajib diisi');
      return;
    }

    // read: hanya memanggil method, tidak perlu mendengarkan perubahan.
    context.read<DaftarTugas>().tambah(
      judul: judul,
      mataKuliah: mataKuliah,
      tenggat: _tenggat,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final galat = _galat;

    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _judul,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Judul tugas',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _mataKuliah,
            decoration: const InputDecoration(
              labelText: 'Mata kuliah',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: skema.outline),
              borderRadius: BorderRadius.circular(4),
            ),
            title: const Text('Tenggat'),
            subtitle: Text(formatTanggal(_tenggat)),
            trailing: const Icon(Icons.calendar_today),
            onTap: _pilihTenggat,
          ),
          if (galat != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(galat, style: TextStyle(color: skema.error)),
            ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _simpan, child: const Text('Simpan')),
        ],
      ),
    );
  }
}
