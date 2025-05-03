import 'package:dompetku_application/historypage/riwayat.dart';
import 'package:dompetku_application/homepage/beranda.dart';
import 'package:dompetku_application/modals/modal_transaksi.dart';
import 'package:dompetku_application/tambahpage/tambah_transaksi.dart';
import 'package:dompetku_application/theme/theme.dart';
import 'package:dompetku_application/widgets/bottom_navbar.dart';
import 'package:dompetku_application/widgets/splash.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme, // tambahin ini
      home: SplashScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Halaman-halaman yang akan ditampilkan pada Bottom Navigation
  List<Widget> _pages = [
    BerandaScreen(), // halaman utama
    TambahScreen(), // halaman tambah
    RiwayatScreen(), // halaman riwayat
  ];

  // Fungsi untuk merubah halaman berdasarkan index yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                BottomNavbarScreen(
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                  jumlahTombol: _pages.length,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 40), // posisi FAB relatif ke BottomNavbar
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        isScrollControlled: true,
                        builder: (context) => ModalTransaksiScreen(),
                      );
                    },
                    backgroundColor: Colors.blueAccent,
                    child: const Icon(LucideIcons.plus, size: 30),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
