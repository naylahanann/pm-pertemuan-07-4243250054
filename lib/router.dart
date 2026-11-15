import 'package:go_router/go_router.dart';

import 'cangkang_navigasi.dart';
import 'halaman_daftar.dart';
import 'halaman_form.dart';
import 'halaman_statistik.dart';

/// Rute:
///   /           -> HalamanDaftar (tab Tugas)
///   /statistik  -> HalamanStatistik (tab Statistik)
///   /tambah     -> HalamanForm (di luar shell, dibuka dengan push)
final router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => CangkangNavigasi(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HalamanDaftar(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistik',
              builder: (context, state) => const HalamanStatistik(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: '/tambah', builder: (context, state) => const HalamanForm()),
  ],
);
