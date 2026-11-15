import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'daftar_tugas.dart';

class CangkangNavigasi extends StatelessWidget {
  const CangkangNavigasi({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    // select: widget ini hanya dibangun ulang bila jumlah tugas aktif
    // berubah, bukan setiap kali isi daftar berubah.
    final aktif = context.select<DaftarTugas, int>((d) => d.jumlahAktif);

    Widget lencana(IconData ikon) {
      return Badge(
        isLabelVisible: aktif > 0,
        label: Text('$aktif'),
        child: Icon(ikon),
      );
    }

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (indeks) => shell.goBranch(
          indeks,
          initialLocation: indeks == shell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: lencana(Icons.checklist_outlined),
            selectedIcon: lencana(Icons.checklist),
            label: 'Tugas',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
        ],
      ),
    );
  }
}
