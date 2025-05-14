import 'package:dompetku_application/card/empty_tabungan.dart';
import 'package:dompetku_application/card/tabungan_card.dart';
import 'package:dompetku_application/db/db_tabungan.dart';
import 'package:dompetku_application/notifer/notifiers.dart'; // Import untuk notifier
import 'package:dompetku_application/tabungan/tabungan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressWidget extends StatefulWidget {
  final double progress;
  const ProgressWidget({super.key, this.progress = 0.3});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  late Future<List<Map<String, dynamic>>> _tabunganFuture;

  @override
  void initState() {
    super.initState();
    _tabunganFuture = DBTabungan().getTabungan();

    // Mendengarkan perubahan pada tabunganNotifier
    tabunganNotifier.addListener(_onTabunganUpdated);
  }

  @override
  void dispose() {
    // Menghapus listener ketika widget dihancurkan
    tabunganNotifier.removeListener(_onTabunganUpdated);
    super.dispose();
  }

  // Callback untuk memperbarui data ketika tabunganNotifier berubah
  void _onTabunganUpdated() {
    setState(() {
      _tabunganFuture = DBTabungan().getTabungan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/tabungan.svg',
                  width: 40, height: 40),
              const SizedBox(width: 5),
              const Text('Progres Tabungan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TabunganScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _tabunganFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text('Terjadi kesalahan saat memuat data');
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return TabunganCardScreen(); // Tampilkan kartu tabungan
              } else {
                return const EmptyTabunganScreen(); // Tampilkan kosong
              }
            },
          ),
        ],
      ),
    );
  }
}
